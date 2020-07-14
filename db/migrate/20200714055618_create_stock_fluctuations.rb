class CreateStockFluctuations < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_fluctuations do |t|
      t.integer :stock
      t.integer :allocate
      t.boolean :unlimited_flg, default: false, null: false
      t.integer :stock_management_id
      t.text :memo
      t.timestamps
    end
  end
end
