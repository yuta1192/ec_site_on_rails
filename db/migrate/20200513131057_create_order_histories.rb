class CreateOrderHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_histories do |t|
      t.string :order_number
      t.text :memo
      t.integer :status
      t.belongs_to :user
      t.belongs_to :cart

      t.timestamps
    end
  end
end
