class ColumnChangeToPaymentMethodSettings < ActiveRecord::Migration[5.2]
  def change
    # remove
    remove_column :payment_method_settings, :amount_collected_1
    remove_column :payment_method_settings, :cash_on_delivery_charge_1
    remove_column :payment_method_settings, :amount_collected_2
    remove_column :payment_method_settings, :cash_on_delivery_charge_2
    remove_column :payment_method_settings, :amount_collected_3
    remove_column :payment_method_settings, :cash_on_delivery_charge_3
    remove_column :payment_method_settings, :amount_collected_4
    remove_column :payment_method_settings, :cash_on_delivery_charge_4
    remove_column :payment_method_settings, :amount_collected_5
    remove_column :payment_method_settings, :cash_on_delivery_charge_5
    remove_column :payment_method_settings, :amount_collected_6
    remove_column :payment_method_settings, :cash_on_delivery_charge_6
    remove_column :payment_method_settings, :cash_on_delivery_charge_7
    # add
    add_column :payment_method_settings, :amount_collected_1, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_1, :integer
    add_column :payment_method_settings, :amount_collected_2, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_2, :integer
    add_column :payment_method_settings, :amount_collected_3, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_3, :integer
    add_column :payment_method_settings, :amount_collected_4, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_4, :integer
    add_column :payment_method_settings, :amount_collected_5, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_5, :integer
    add_column :payment_method_settings, :amount_collected_6, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_6, :integer
    add_column :payment_method_settings, :cash_on_delivery_charge_7, :integer
  end
end
