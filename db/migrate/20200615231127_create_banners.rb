class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.string :name
      t.timestamps
    end
  end
end
