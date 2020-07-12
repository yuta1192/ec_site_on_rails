class AddColumnsToManyTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :member_code, :string
    add_column :users, :remark, :text
    add_column :products, :set_flg, :boolean, default: false, null: false
    add_column :products, :set_num, :integer
    add_column :products, :shipping_origin, :integer
    add_column :products, :shipping_company, :string
    add_column :addresses, :company_code, :string
    add_column :addresses, :department_code, :string
    add_column :addresses, :fax, :string
    add_column :shipment_products, :invoice_number, :string
    add_column :shipment_products, :shipping_email_flg, :boolean, default: false, null: false
    add_column :shipment_products, :billing_date, :date
  end
end
