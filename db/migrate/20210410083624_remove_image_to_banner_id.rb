class RemoveImageToBannerId < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :banner_id
    remove_column :banners, :image
    add_column :banners, :image_id, :integer
  end
end
