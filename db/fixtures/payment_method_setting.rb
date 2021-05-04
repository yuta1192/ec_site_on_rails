# 支払い方法（PaymentMethodSetting）

string = 1000

PaymentMethodSetting.seed do |pms|
  pms.payment_method = 1
  pms.payee_memo = "text_memo"
  pms.cash_on_delivery_charge_flg = true
  pms.amount_collected_1 = string
  pms.cash_on_delivery_charge_1 = string
  pms.amount_collected_2 = string
  pms.cash_on_delivery_charge_2 = string
  pms.amount_collected_3 = string
  pms.cash_on_delivery_charge_3 = string
  pms.amount_collected_4 = string
  pms.cash_on_delivery_charge_4 = string
  pms.amount_collected_5 = string
  pms.cash_on_delivery_charge_5 = string
  pms.amount_collected_6 = string
  pms.cash_on_delivery_charge_6 = string
  pms.cash_on_delivery_charge_7 = string
  pms.cash_on_delivery_charge_memo = "text_cash_on_delivery_charge_memo"
  pms.deadline_memo = "text_deadline_memo"
end
