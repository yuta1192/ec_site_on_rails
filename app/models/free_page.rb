class FreePage < ApplicationRecord
  has_many :page_contents
  accepts_nested_attributes_for :page_contents
end
