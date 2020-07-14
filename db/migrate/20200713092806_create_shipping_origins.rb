class CreateShippingOrigins < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_origins do |t|
      t.integer :status
      t.string :origin_id
      t.string :password_digest
      t.string :shipping_origin_name
      t.string :shipping_origin_email
      t.timestamps
    end
  end
end
