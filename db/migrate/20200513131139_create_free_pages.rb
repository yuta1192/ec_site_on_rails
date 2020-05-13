class CreateFreePages < ActiveRecord::Migration[5.2]
  def change
    create_table :free_pages do |t|
      t.string :title
      t.string :second_title
      t.text :sentence

      t.timestamps
    end
  end
end
