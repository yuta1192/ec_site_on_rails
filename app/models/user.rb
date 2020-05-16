class User < ApplicationRecord
#  has_many :addresses
#  has_many :order_histories
#  belongs_to :cart
#  has_many :contact
#  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password validations: true
  validates :e_mail, presence: true, uniqueness: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
