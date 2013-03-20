class StoreController < ApplicationController
  def index
    @products = Product.order(:price)
    @card = current_card
  end
end
