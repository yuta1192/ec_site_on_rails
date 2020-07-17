class CreateCartMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_memos do |t|
      t.text :memo
      t.timestamps
    end
  end
end
