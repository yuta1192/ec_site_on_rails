class CartMemo < ApplicationRecord
  # 会員のカートに表示するメモ
  # position 1(上部), 2(下部)
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }, presence: true
  validates :memo, presence: true
end
