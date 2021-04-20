class AddColumnToImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :banner_type
    add_column :images, :banner_id, :integer
  end
end
