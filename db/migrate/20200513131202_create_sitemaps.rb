class CreateSitemaps < ActiveRecord::Migration[5.2]
  def change
    create_table :sitemaps do |t|
      t.string :map_name

      t.timestamps
    end
  end
end
