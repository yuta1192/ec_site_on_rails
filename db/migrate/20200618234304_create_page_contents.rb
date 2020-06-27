class CreatePageContents < ActiveRecord::Migration[5.2]
  def change
    create_table :page_contents do |t|
      t.string :title
      t.text :sentence
      t.integer :free_page_id
      t.timestamps
    end
  end
end
