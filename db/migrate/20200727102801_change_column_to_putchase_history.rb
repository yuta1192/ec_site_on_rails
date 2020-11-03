class ChangeColumnToPutchaseHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :Purchase_histories, :cart_id
    add_column :Purchase_histories, :product_id, :integer
    add_column :Purchase_histories, :stock, :integer
  end
end
