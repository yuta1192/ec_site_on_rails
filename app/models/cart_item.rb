class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :purchase_history
end
