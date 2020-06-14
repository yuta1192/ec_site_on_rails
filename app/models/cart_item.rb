class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order_history
end
