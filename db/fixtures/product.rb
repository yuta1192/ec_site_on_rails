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

# 数量
100.times do |i|
  StockManagement.seed do |s|
    s.id = i+1
    s.stock = 30
    s.allocate = 1
    s.unlimited_flg = false
    s.product_id = i+1
  end
end

# productを100個作成
100.times do |i|
  category = [1,2,3,4,5].sample
  Product.seed do |s|
    s.id = i+1
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
    s.image = File.open(['./public/uploads/product/image/1/something.jpg', './public/uploads/product/image/2/youtuber_mask_sunglass.png',
                        './public/uploads/product/image/3/otaku_fujoshi_winter.png', './public/uploads/product/image/4/bunbougu_nerikeshi.png',
                        './public/uploads/product/image/5/medical_virus_kouseibusshitsu_yakuzai_taiseikin.png'].sample)
  end
end

# OrderHistory作成
100.times do |i|
  OrderHistory.seed do |s|
    s.id = i+1
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
    s.shipment_id = nil

    5.times do |f|
      OrderHistoryProduct.seed do |ohp|
        ohp.order_history_id = i+1
        ohp.product_id = rand(1..100)
        ohp.num = rand(1..10)
      end
    end
  end
end
