# メール系（MailSetting）

MailSetting.seed do |ms|
  ms.use_basic_email_flg = true
  ms.password_reissue_sender = "string"
  ms.password_reissue_destination = "string"
  ms.order_change_sender = "string"
  ms.order_change_destination = "string"
  ms.shipping_sender = "string"
  ms.shipping_destination = "string"
  ms.cancel_sender = "string"
  ms.cancel_destination = "string"
  ms.stock_notification_sender = "string"
  ms.stock_notification_destination = "string"
  ms.shipment_request_change_sender = "string"
  ms.shipment_request_change_destination = "string"
  ms.user_password_reissue_sender = "string"
  ms.user_password_change_sender = "string"
  ms.user_thank_you_change_sender = "string"
  ms.user_shipping_sender = "string"
  ms.user_cancel_sender = "string"
  ms.base_mail_address = "base_email@base.com"
  ms.ikiti = 100
end
