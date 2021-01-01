class CreateUserMyListProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_my_list_products do |t|
      t.integer :mylist_id
      t.integer :product_id
      t.timestamps
    end
  end
end
