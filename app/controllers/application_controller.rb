class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_card
    Card.find(session[:card_id])
  rescue ActiveRecord::RecordNotFound
    card = Card.create
    session[:card_id] = card.id
    card
  end
end
