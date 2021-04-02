# 送料設定（ShippingSetting）

ShippingSetting.seed do |ss|
  ss.free_shipping_service = "これは何？"
  ss.basic_setting = 1
  ss.nationwide_rate = "nationwide_rateこれは何"
  ss.same_shipping_rate_setting = "same_shipping_rate_settingこれは何"
  ss.postage_id = [1..46].sample
  ss.postage_consumption_tax = 10
end
