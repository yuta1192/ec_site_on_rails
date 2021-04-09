class OrderHistoryProduct < ApplicationRecord
  # 注文履歴内の商品情報
  belongs_to :order_history
  belongs_to :product

  scope :range_current_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :range_yesterday, -> { where(created_at: Time.now.yesterday.beginning_of_day..Time.now.yesterday.end_of_month) }
  scope :range_today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_month) }
end
