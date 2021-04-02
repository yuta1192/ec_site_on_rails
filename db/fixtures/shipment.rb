# 出荷系（Shipment、ShipmentProduct）

# todo 一旦コメント
# 50.times do |i|
#   Shipment.seed do |s|
#     s.shipping_status = [1,2,3,4,nil].sample
#     s.allocation_status = [1,2,3,nil].sample
#     s.expected_shipping_date = Date.today
#     s.shipping_company = [1,2,3,4].sample
#     s.ship_date = Date.today
#     s.shipping_email = [true, false].sample
#     s.billing_date = Date.today
#     s.sales_record_date = Date.today
#     s.data_download = 99
#     s.total_picking = [true, false].sample
#     s.individual_picking = [true, false].sample
#     s.order_history_id = 1
#     s.cancel_flg = [true, false].sample
#     s.shipping_origin_id = 1
#     s.prefectures = [1..46].sample
#     s.order_date = Date.today
#     s.preferred_arrival_date = Date.today
#     s.arrival_date_flg = [true, false].sample
#     s.expected_shipping_date_flg = [true, false].sample
#     s.sales_record_date_flg = [true, false].sample
#   end
#
#   ShipmentProduct.seed do |sp|
#     sp.shipment_id = i
#     sp.product_id = i
#     sp.num = 10
#     sp.status = 1
#     sp.picking_flg = [true, false].sample
#     sp.csv_flg = [true, false].sample
#     sp.expected_shipping_date = Date.today
#     sp.ship_date = Date.today
#     sp.invoice_number = "string_invoice_number_#{i}"
#     sp.shipping_email_flg = [true, false].sample
#     sp.billing_date = Date.today
#   end
# end
#
