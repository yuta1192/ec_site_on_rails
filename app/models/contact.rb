class Contact < ApplicationRecord
  validates :contact, presence: true
  belongs_to :user
end
