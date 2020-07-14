class AddStockManagementIdToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :stock_management_id, :integer
  end
end
