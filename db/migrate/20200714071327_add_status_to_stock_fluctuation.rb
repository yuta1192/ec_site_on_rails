class AddStatusToStockFluctuation < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_fluctuations, :status, :integer
  end
end
