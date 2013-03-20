class LineItem < ActiveRecord::Base
  attr_accessible :card_id, :product_id
  attr_accessible :product
  belongs_to :product
  belongs_to :card
  belongs_to :order
  
  def total_price
    product.price * quantity
  end
  
end
