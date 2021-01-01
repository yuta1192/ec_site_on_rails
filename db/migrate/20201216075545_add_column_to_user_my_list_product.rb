class AddColumnToUserMyListProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :user_my_list_products, :quantity, :integer
  end
end
