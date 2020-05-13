class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :detail
      t.integer :category
      t.integer :child_category
      t.integer :price
      t.integer :member_price
      t.integer :stock
      t.string :product_number
      t.boolean :postage_flg, null:false, default:false
      t.integer :postage

      t.timestamps
    end
  end
end
