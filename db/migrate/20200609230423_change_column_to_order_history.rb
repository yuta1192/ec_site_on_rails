class ChangeColumnToOrderHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :order_histories, :cart_number, :string
    add_column :order_histories, :cart_product_id, :integer
  end
end
