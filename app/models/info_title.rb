class InfoTitle < ApplicationRecord
  belongs_to :information
  validates :title, presence: true
end
