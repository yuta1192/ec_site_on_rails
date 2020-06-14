class PurchaseHistory < ApplicationRecord
  has_many :cart_items
  belongs_to :delivery_info
end
