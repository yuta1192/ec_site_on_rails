class AddColumnToMyList < ActiveRecord::Migration[5.2]
  def change
    add_column :my_lists, :user_id, :integer
    add_column :my_lists, :product_id, :integer
  end
end
