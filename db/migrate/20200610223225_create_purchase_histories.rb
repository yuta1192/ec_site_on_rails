class CreatePurchaseHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_histories do |t|
      t.integer :cart_id
      t.string :cart_number
      t.timestamps
    end
  end
end
