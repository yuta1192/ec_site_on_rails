class AddColumnToShipment < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :order_history_id, :integer
    add_column :shipments, :cancel_flg, :boolean, default: false, null: false
    add_column :shipments, :shipping_origin, :integer
    add_column :shipments, :prefectures, :integer
    add_column :shipments, :order_date, :date
    add_column :shipments, :preferred_arrival_date, :date
    add_column :shipments, :arrival_date_flg, :boolean, default: false, null: false
    add_column :shipments, :expected_shipping_date_flg, :boolean, default: false, null: false
    add_column :shipments, :sales_record_date_flg, :boolean, default: false, null: false
    add_column :order_histories, :shipment_id, :integer
  end
end
