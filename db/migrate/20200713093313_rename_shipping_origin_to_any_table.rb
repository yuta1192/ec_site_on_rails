class RenameShippingOriginToAnyTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :shipping_origin, :shipping_origin_id
    rename_column :order_histories, :shipping_origin, :shipping_origin_id
    rename_column :shipments, :shipping_origin, :shipping_origin_id
  end
end
