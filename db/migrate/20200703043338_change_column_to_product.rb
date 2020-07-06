class ChangeColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    rename_column :Products, :category, :category_name
    rename_column :Products, :child_category, :category_id
  end
end
