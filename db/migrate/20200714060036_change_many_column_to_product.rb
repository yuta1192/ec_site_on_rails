class ChangeManyColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :category_name
    remove_column :products, :stock
  end
end
