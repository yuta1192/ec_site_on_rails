class CreatePaymentMethodSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_method_settings do |t|

      t.timestamps
    end
  end
end
