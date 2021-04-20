class RemoveColumnsToProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :category_name, :string
  end
end
