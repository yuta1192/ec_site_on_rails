class ChangeManyColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :Products, :category_name
    remove_column :Products, :stock
  end
end
