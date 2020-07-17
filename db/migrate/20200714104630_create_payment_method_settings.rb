class CreatePaymentMethodSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_method_settings do |t|
      t.integer :payment_method
      t.text :payee_memo
      t.boolean :cash_on_delivery_charge_flg, default: true, null: false
      t.string :amount_collected_1
      t.string :cash_on_delivery_charge_1
      t.string :amount_collected_2
      t.string :cash_on_delivery_charge_2
      t.string :amount_collected_3
      t.string :cash_on_delivery_charge_3
      t.string :amount_collected_4
      t.string :cash_on_delivery_charge_4
      t.string :amount_collected_5
      t.string :cash_on_delivery_charge_5
      t.string :amount_collected_6
      t.string :cash_on_delivery_charge_6
      t.string :cash_on_delivery_charge_7
      t.text :cash_on_delivery_charge_memo
      t.text :deadline_memo
      t.timestamps
    end
  end
end
