class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.integer :shipping_status
      t.integer :allocation_status
      t.date :expected_shipping_date
      t.integer :shipping_company
      t.date :ship_date
      t.boolean :shipping_email, default: false, null: false
      t.date :billing_date
      t.date :sales_record_date
      t.integer :data_download
      t.boolean :total_picking, default: false, null: false
      t.boolean :individual_picking, default: false, null: false
      t.timestamps
    end
  end
end
