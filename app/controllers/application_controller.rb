class ApplicationController < ActionController::Base
  before_filter :autorize
  protect_from_forgery
    
  private
  
  def current_card
    Card.find(session[:card_id])
  rescue ActiveRecord::RecordNotFound
    card = Card.create
    session[:card_id] = card.id
    card
  end
  
  protected
  
  def autorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please registration!"
    end
  end
  
end
