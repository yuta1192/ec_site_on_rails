class AddColumnToDeliveryInfos < ActiveRecord::Migration[5.2]
  def change
    remove_column :delivery_infos, :delevery_day
    add_column :delivery_infos, :delivery_day, :date
  end
end
