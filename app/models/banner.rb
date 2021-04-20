class Banner < ApplicationRecord
  # hyoji_area 1:ロゴ, 2:トップ画面 3:会員の左メニューのバナー, 4:下のバナー
  has_one :image

  validates :hyoji_area, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
  validates :name, presence: true
  validates :image, presence: true
end
