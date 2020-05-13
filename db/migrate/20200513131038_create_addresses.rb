class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :company_name
      t.string :department_name
      t.string :name_sei
      t.string :name_mei
      t.string :name_sei_kana
      t.string :name_mei_kana
      t.integer :zip_code
      t.integer :prefectures
      t.string :municipation
      t.string :address_1
      t.string :address_2
      t.integer :tel
      t.integer :phone_number
      t.belongs_to :user

      t.timestamps
    end
  end
end
