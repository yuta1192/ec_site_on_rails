class CreateInfoTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :info_titles do |t|
      t.string :title
      t.integer :hyoji_count
      t.timestamps
    end
  end
end
