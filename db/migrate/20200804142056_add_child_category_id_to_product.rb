class AddChildCategoryIdToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :child_category_id, :integer
  end
end
