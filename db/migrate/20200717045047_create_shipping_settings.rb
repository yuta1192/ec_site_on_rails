class CreateShippingSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_settings do |t|
      t.string :free_shipping_service
      t.integer :basic_setting
      t.string :nationwide_rate
      t.string :same_shipping_rate_setting
      t.integer :postage_id
      t.integer :postage_consumption_tax
      t.timestamps
    end
  end
end
