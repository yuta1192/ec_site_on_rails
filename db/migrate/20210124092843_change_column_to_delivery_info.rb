class ChangeColumnToDeliveryInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :delivery_infos, :zip_code
    add_column :delivery_infos, :zip_code, :string
  end
end
