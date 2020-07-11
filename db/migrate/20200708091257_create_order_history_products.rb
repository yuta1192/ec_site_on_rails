class CreateOrderHistoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_history_products do |t|
      t.integer :order_history_id
      t.integer :product_id
      t.integer :num
      t.timestamps
    end
  end
end
