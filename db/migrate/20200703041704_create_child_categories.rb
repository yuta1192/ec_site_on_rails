class CreateChildCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :child_categories do |t|
      t.integer :category_id
      t.string :name
      t.timestamps
    end
  end
end
