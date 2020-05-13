class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item
      t.belongs_to :sitemap

      t.timestamps
    end
  end
end
