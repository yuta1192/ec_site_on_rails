class OrderHistoryAddAddressId < ActiveRecord::Migration[5.2]
  def change
    add_column :order_histories, :address_id, :integer
  end
end
