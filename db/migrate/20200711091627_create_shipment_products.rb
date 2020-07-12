class CreateShipmentProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_products do |t|
      t.integer :shipment_id
      t.integer :product_id
      t.integer :num
      t.integer :status
      t.boolean :picking_flg, default: false, null: false
      t.boolean :csv_flg, default: false, null: false
      t.date :expected_shipping_date
      t.date :ship_date
      t.timestamps
    end
  end
end
