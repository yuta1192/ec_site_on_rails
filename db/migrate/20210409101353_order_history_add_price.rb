class OrderHistoryAddPrice < ActiveRecord::Migration[5.2]
  def change
    add_column :order_histories, :price, :integer
    add_column :order_histories, :excluding_tax_price, :integer
  end
end
