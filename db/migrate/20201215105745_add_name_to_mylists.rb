class AddNameToMylists < ActiveRecord::Migration[5.2]
  def change
    add_column :my_lists, :name, :string
    remove_column :my_lists, :product_id
  end
end
