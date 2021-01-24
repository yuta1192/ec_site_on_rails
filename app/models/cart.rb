class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :order_histories
  has_many :products
end
