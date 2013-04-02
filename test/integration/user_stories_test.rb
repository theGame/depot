require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do 
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
    get "/"
    assert_response :success
    assert_template "index"
    
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
    
    card = Card.find(session[:card_id])
    assert_equal 1, card.line_items.size
    assert_equal ruby_book, card.line_items[0].product
    
    get "/orders/new"
    assert_response :success
    assert_templte "new"
    
    post_via_redirect "/orders", order: { name: "Dave Thomas",
                                          address: "124 The Street",
                                          email: "deve@examp.com",
                                          pay_type: "Check" }
    assert_response :success
    assert_template "index"
    card = Card.find(session[:card_id])
    assert_equal 0, card.line_items.size
    
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal "Dave Thomas",   order.name
    assert_equal "124 The Street",   order.address
    assert_equal "deve@examp.com",   order.email
    assert_equal "Check",   order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
    
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@examp.com"], mail.to
    assert_equal 'Sam Ruby <depot@examp.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
                                      
  end
end
