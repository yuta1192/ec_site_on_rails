class AddColumnToOrderHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :order_histories, :delivery_info_id, :integer
  end
end
