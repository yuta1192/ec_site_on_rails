class OrderHistory < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :cart_product
  has_many :product
end
