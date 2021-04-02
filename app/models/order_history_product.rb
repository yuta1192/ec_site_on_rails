class OrderHistoryProduct < ApplicationRecord
  # 注文履歴内の商品情報
  belongs_to :order_history
  belongs_to :product
end
