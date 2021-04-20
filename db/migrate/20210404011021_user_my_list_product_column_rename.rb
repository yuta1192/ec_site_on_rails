class UserMyListProductColumnRename < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_my_list_products, :mylist_id, :my_list_id
  end
end
