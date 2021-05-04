class ColumnAddToMailSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :mail_settings, :base_mail_address, :string
    add_column :mail_settings, :ikiti, :integer
  end
end
