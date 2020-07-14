class CreateMailSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_settings do |t|
      t.boolean :use_basic_email_flg, default: true, null: false
      t.string :password_reissue_sender
      t.string :password_reissue_destination
      t.string :order_change_sender
      t.string :order_change_destination
      t.string :shipping_sender
      t.string :shipping_destination
      t.string :cancel_sender
      t.string :cancel_destination
      t.string :stock_notification_sender
      t.string :stock_notification_destination
      t.string :shipment_request_change_sender
      t.string :shipment_request_change_destination
      t.string :user_password_reissue_sender
      t.string :user_password_change_sender
      t.string :user_thank_you_change_sender
      t.string :user_shipping_sender
      t.string :user_cancel_sender
      t.timestamps
    end
  end
end
