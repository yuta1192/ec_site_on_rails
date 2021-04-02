class Banner < ApplicationRecord
  # hyoji_area 1:会員の左メニューのバナー, 2:下のバナー
  mount_uploader :image, ImageUploader
  validates :hyoji_area, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  validates :name, presence: true
  validates :image, presence: true
end
