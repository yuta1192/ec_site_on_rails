class AddColumnToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :cart_number, :string
  end
end
