class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image
      t.string :url
      t.string :name
      t.boolean :is_banner_flg, default: false, null: false
      t.integer :banner_type
      t.text :comment
      t.timestamps
    end
  end
end
