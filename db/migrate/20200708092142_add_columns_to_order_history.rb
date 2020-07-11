class AddColumnsToOrderHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :order_histories, :order_date_start, :date
    add_column :order_histories, :order_date_end, :date
    add_column :order_histories, :preferred_date_flg, :boolean, default: false, null: false
    add_column :order_histories, :preferred_date_start, :date
    add_column :order_histories, :preferred_date_end, :date
    add_column :order_histories, :invoice_number, :string
    add_column :order_histories, :payment_method, :integer
    add_column :order_histories, :payment, :integer
    add_column :order_histories, :allocation_status, :integer
    add_column :order_histories, :shipping_status, :integer
    add_column :order_histories, :postage_confirmation, :boolean, default: false, null: false
    add_column :order_histories, :shipping_origin, :integer
    add_column :order_histories, :cancel_flg, :boolean, default: false, null: false
  end
end
