class AddOrderHistoryIdToPurchaseHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_histories, :order_history_id, :integer
  end
end
