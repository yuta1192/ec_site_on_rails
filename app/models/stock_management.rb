class StockManagement < ApplicationRecord
  belongs_to :product
  has_many :stock_fluctuations
end
