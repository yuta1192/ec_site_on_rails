class AddImageToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :image, :string
  end
end
