class CreateStockManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_managements do |t|
      t.integer :stock
      t.integer :allocate
      t.boolean :unlimited_flg, default: false, null: false
      t.integer :product_id
      t.timestamps
    end
  end
end
