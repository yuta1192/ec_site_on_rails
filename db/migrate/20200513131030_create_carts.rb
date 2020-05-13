class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :cart_number
      t.belongs_to :cart
      t.belongs_to :order_history

      t.timestamps
    end
  end
end
