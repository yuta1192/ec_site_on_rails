class AddColumnToBanner < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :comment, :text
    add_column :banners, :hyoji_area, :integer
  end
end
