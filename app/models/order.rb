class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  has_many :line_items, dependent: :destroy
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  def add_line_items_form_card(card)
    card.line_items.each do |item|
      item.card_id = nil
      line_items << item
    end
  end
  
end
