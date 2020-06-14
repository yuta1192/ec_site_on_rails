class AddColumnToDeliveryInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_infos, :zip_code, :integer
  end
end
