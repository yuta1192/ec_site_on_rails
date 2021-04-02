class MemberRank < ApplicationRecord
  # recalculation これなんだ？？
  # multiplication_rate 割引率

  validates :multiplication_rate, numericality: { only_integer: true }, presence: true
end
