class AddColumnToImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :Images, :banner_type
    add_column :Images, :banner_id, :integer
  end
end
