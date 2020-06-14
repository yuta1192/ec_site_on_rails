class CreateDeliveryInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_infos do |t|
      t.string :company_name
      t.string :user_name
      t.string :address
      t.string :tel
      t.string :phone_number
      t.date :delevery_day
      t.timestamps
    end
  end
end
