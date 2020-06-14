class RemoveCartProductIdToOrderHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_histories, :cart_product_id
    add_column :order_histories, :purchase_history_id, :integer
  end
end
