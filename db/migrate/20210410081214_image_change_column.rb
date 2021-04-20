class ImageChangeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :image
    add_column :images, :image, :binary
  end
end
