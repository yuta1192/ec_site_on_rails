class AddColumnToPurchaseHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_histories, :delivery_info_id, :integer
  end
end
