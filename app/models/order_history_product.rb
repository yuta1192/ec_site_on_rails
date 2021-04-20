class OrderHistoryProduct < ApplicationRecord
  # 注文履歴内の商品情報
  belongs_to :order_history
  belongs_to :product

  scope :range_current_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }
  scope :range_yesterday, -> { where(created_at: Time.current.yesterday.beginning_of_day..Time.current.yesterday.end_of_day) }
  scope :range_today, -> { where(created_at: Time.current.beginning_of_day..Time.current.end_of_day) }
end
