class User < ApplicationRecord
  has_many :addresses
  has_many :order_histories
  belongs_to :cart
  has_many :contact
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
