class OrderHistory < ApplicationRecord
  belongs_to :user
  has_one :purchase_history
  has_one :delivery_info
  has_many :cart_items
end
