class AddColumnToUserAndAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :integer
    add_column :users, :rank, :integer
    add_column :users, :name_sei, :string
    add_column :users, :name_mei, :string
    add_column :users, :name_sei_kana, :string
    add_column :users, :name_mei_kana, :string
    add_column :users, :zip_code, :string
    add_column :users, :prefectures, :integer
    add_column :users, :municipation, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :tel, :string
    add_column :users, :fax, :string
    add_column :users, :payment_method, :integer
    add_column :users, :company_name_kana, :string
    add_column :users, :company_code, :string
    add_column :users, :department_name_kana, :string
    add_column :users, :department_code, :string
    add_column :users, :member_id, :string
    change_column :users, :phone_number, :string
    remove_column :users, :name
    remove_column :users, :contact_name
    add_column :addresses, :delivery_id, :string
    change_column :addresses, :zip_code, :string
    change_column :addresses, :tel, :string
    change_column :addresses, :phone_number, :string
  end
end
