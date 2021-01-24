class Removecolumntoany < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :order_history_id
    remove_column :users, :cart_id
  end
end
