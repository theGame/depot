class StoreController < ApplicationController
    skip_before_filter :autorize
  def index
    @products = Product.order(:price)
    @card = current_card
  end
end
