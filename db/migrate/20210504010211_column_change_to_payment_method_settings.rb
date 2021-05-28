class ColumnChangeToPaymentMethodSettings < ActiveRecord::Migration[5.2]
  def change
    change_column :payment_method_settings, :amount_collected_1, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_1, :integer
    change_column :payment_method_settings, :amount_collected_2, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_2, :integer
    change_column :payment_method_settings, :amount_collected_3, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_3, :integer
    change_column :payment_method_settings, :amount_collected_4, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_4, :integer
    change_column :payment_method_settings, :amount_collected_5, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_5, :integer
    change_column :payment_method_settings, :amount_collected_6, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_6, :integer
    change_column :payment_method_settings, :cash_on_delivery_charge_7, :integer
  end
end
