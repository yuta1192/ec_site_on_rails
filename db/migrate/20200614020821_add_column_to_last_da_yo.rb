class AddColumnToLastDaYo < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchase_histories, :delivery_info_id
    remove_column :order_histories, :purchase_history_id
    remove_column :order_histories, :delivery_info_id
    add_column :delivery_infos, :purchase_history_id, :integer
    add_column :delivery_infos, :order_history_id, :integer
    add_column :cart_items, :order_history_id, :integer
  end
end
