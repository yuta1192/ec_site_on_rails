# randamな文字取得
require 'securerandom'

# productで使用するため、先にcategory作成
# カテゴリー
Category.seed do |s|
  s.id = 1
  s.name = "日常品"
end

Category.seed do |s|
  s.id = 2
  s.name = "食品"
end

Category.seed do |s|
  s.id = 3
  s.name = "嗜好品"
end

Category.seed do |s|
  s.id = 4
  s.name = "動画"
end

Category.seed do |s|
  s.id = 5
  s.name = "国"
end

# 子カテゴリー
10.times do |i|
  ChildCategory.seed do |s|
    s.id = i+1
    s.category_id = [1,2,3,4,5].sample
    s.name = "子カテゴリー#{i+1}"
  end
end

# productを100個作成
100.times do |i|
  category = [1,2,3,4,5].sample
  Product.seed do |s|
    s.name = "sample#{i}"
    s.detail = "samplesamplesamplesamplesamplesamplesamplesamplesamplesamplesamplesamplesamplesample#{i}"
    s.category_id = category
    s.price = i+1000
    s.member_price = i+900
    s.product_number = "productnumber#{i}"
    s.postage_flg = false
    s.postage = nil
    s.jan_code = "jan_code_#{i}"
    s.shipping_location = nil
    s.notification_email = "oddsad@gmail.com"
    s.new_flg = [true, false].sample
    s.popular_flg = [true, false].sample
    s.comment = "#{i+1}_no_comment"
    s.explanation_1 = "説明文1_#{i+1}"
    s.explanation_2 = "説明文1_#{i+1}"
    s.tax_flg = true
    s.manufacturer = nil
    s.remote_island_shipping_confirmation = true
    s.display_period_start = nil
    s.display_period_end = nil
    s.purchase_limit = nil
    s.postage_comment = nil
    s.is_release_flg = [true, false].sample
    s.set_flg = [true, false].sample
    s.set_num = i+1
    s.shipping_origin_id = nil
    s.shipping_company = nil
    s.stock_management_id = i+1
    s.child_category_id = ChildCategory.where(category_id: category).present? ? (ChildCategory.where(category_id: category).pluck(:id) << nil).sample : nil
    # s.image = File.open(["./db/fixtures/image_file/014.jpg","./db/fixtures/image_file/5503321i.jpeg","./db/fixtures/image_file/arm_tablet (1).png","./db/fixtures/image_file/karaoke.png","./db/fixtures/image_file/shopping_supermarket_man.png","./db/fixtures/image_file/shopping_supermarket_family_mother.png","./db/fixtures/image_file/yusyou_champagne_fight.png"].sample)
  end

  StockManagement.seed do |sm|
    sm.stock = 100
    sm.allocate = 1
    sm.unlimited_flg = [true,false].sample
    sm.product_id = i+1
  end

  StockFluctuation.seed do |sf|
    sf.stock = 10
    sf.allocate = 1
    sf.unlimited_flg = [true,false].sample
    sf.stock_management_id = i+1
    sf.memo = "memo_#{i}"
    sf.status = 1
  end
end

# OrderHistory作成
100.times do |i|
  OrderHistory.seed do |s|
    s.order_number = SecureRandom.alphanumeric()
    s.memo = "memo"
    s.status = 1
    s.user_id = 1
    s.cart_id = 1
    s.cart_number = "cart_number"
    s.order_date_start = DateTime.now.ago(1.years)
    s.order_date_end = DateTime.now
    s.preferred_date_flg = false
    s.preferred_date_start = nil
    s.preferred_date_end = nil
    s.invoice_number = nil
    s.payment_method = nil
    s.payment = nil
    s.allocation_status = nil
    s.shipping_status = nil
    s.postage_confirmation = false
    s.shipping_origin_id = nil
    s.cancel_flg = false
    s.shipment_id = i+1
    s.address_id = [1,2,3,4].sample
    s.price = 10000
    s.excluding_tax_price = 9000

    5.times do
      OrderHistoryProduct.seed do |ohp|
        ohp.order_history_id = i+1
        ohp.product_id = rand(1..100)
        ohp.num = rand(1..10)
      end
    end
  end

  Shipment.seed do |s|
    s.shipping_status = [1,2,3,4,nil].sample
    s.allocation_status = [1,2,3,nil].sample
    s.expected_shipping_date = Date.today
    s.shipping_company = [1,2,3,4].sample
    s.ship_date = Date.today
    s.shipping_email = [true, false].sample
    s.billing_date = Date.today
    s.sales_record_date = Date.today
    s.data_download = 99
    s.total_picking = [true, false].sample
    s.individual_picking = [true, false].sample
    s.order_history_id = i
    s.cancel_flg = [true, false].sample
    s.shipping_origin_id = 1
    s.prefectures = [1..46].sample
    s.order_date = Date.today
    s.preferred_arrival_date = Date.today
    s.arrival_date_flg = [true, false].sample
    s.expected_shipping_date_flg = [true, false].sample
    s.sales_record_date_flg = [true, false].sample
    s.order_history_id = i+1
  end

  ShipmentProduct.seed do |sp|
    sp.shipment_id = i+1
    sp.product_id = rand(1..100)
    sp.num = 10
    sp.status = 1
    sp.picking_flg = [true, false].sample
    sp.csv_flg = [true, false].sample
    sp.expected_shipping_date = Date.today
    sp.ship_date = Date.today
    sp.invoice_number = "string_invoice_number_#{i}"
    sp.shipping_email_flg = [true, false].sample
    sp.billing_date = Date.today
  end
end
