class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.boolean :open_flg, default: true, null: false
      t.string :logo
      t.string :name
      t.string :company_name
      t.string :zip_code
      t.integer :prefectures
      t.string :municipation
      t.string :address_1
      t.string :address_2
      t.string :tel
      t.string :fax
      t.string :email
      t.integer :stock_notification_num
      t.integer :payment_method
      t.string :billing_customer_code
      t.integer :product_name_setting
      t.string :name_set
      t.integer :start_condition
      t.boolean :shipped_flg, default: true, null: false
      t.boolean :set_shipping_company_flg, default: true, null: false
      t.integer :product_consumption_tax_flg
      t.integer :tax_rate
      t.timestamps
    end
  end
end
