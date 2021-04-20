class ChangeColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :category, :category_name
    rename_column :products, :child_category, :category_id
  end
end
