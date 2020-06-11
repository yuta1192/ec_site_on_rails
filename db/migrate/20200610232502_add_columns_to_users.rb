class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company_name, :string
    add_column :users, :department_name, :string
    add_column :users, :contact_name, :string
    add_column :users, :phone_number, :integer
  end
end
