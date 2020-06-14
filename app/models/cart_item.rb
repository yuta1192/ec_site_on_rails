class CartItem < ApplicationRecord
  validates :order_history_id, presence: :allow_nil
  belongs_to :product
  belongs_to :cart
  belongs_to :order_history
end
