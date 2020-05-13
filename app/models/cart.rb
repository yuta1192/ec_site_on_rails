class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_histories
  has_many :product
end
