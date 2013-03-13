class LineItem < ActiveRecord::Base
  attr_accessible :card_id, :product_id
  attr_accessible :product
  belongs_to :product
  belongs_to :card
end
