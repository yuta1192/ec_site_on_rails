class CreateProductPages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_pages do |t|
      t.text :up_page_text
      t.text :bottom_page_text
      t.timestamps
    end
  end
end
