class ChangeColumnToPutchaseHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchase_histories, :cart_id
    add_column :purchase_histories, :product_id, :integer
    add_column :purchase_histories, :stock, :integer
  end
end
