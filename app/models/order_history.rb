class OrderHistory < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :product
end
