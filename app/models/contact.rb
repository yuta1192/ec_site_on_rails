class Contact < ApplicationRecord
  validates :contact, presence: true
  validates :user_id, presence: true
  belongs_to :user
end
