# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_17_074429) do

  create_table "Images", force: :cascade do |t|
    t.string "image"
    t.string "url"
    t.string "name"
    t.boolean "is_banner_flg", default: false, null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "banner_id"
  end

  create_table "Information", force: :cascade do |t|
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "release_flg", default: true, null: false
    t.date "published_start"
    t.date "published_end"
    t.string "attachment_file1"
    t.string "attachment_file2"
    t.string "attachment_file3"
    t.string "attachment_file4"
    t.string "attachment_file5"
    t.string "title"
  end

  create_table "Inqueries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "company_name"
    t.string "department_name"
    t.string "name_sei"
    t.string "name_mei"
    t.string "name_sei_kana"
    t.string "name_mei_kana"
    t.string "zip_code"
    t.integer "prefectures"
    t.string "municipation"
    t.string "address_1"
    t.string "address_2"
    t.string "tel"
    t.string "phone_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_select_flag", default: false, null: false
    t.string "company_code"
    t.string "department_code"
    t.string "fax"
    t.string "delivery_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "product_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cart_number"
    t.integer "order_history_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "cart_memos", force: :cascade do |t|
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.string "cart_number"
    t.integer "order_history_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["order_history_id"], name: "index_carts_on_order_history_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "child_categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.text "contact"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "delivery_infos", force: :cascade do |t|
    t.string "company_name"
    t.string "user_name"
    t.string "address"
    t.string "tel"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "zip_code"
    t.date "delivery_day"
    t.integer "purchase_history_id"
    t.integer "order_history_id"
  end

  create_table "free_pages", force: :cascade do |t|
    t.string "page_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "h1_tag"
    t.string "url"
    t.integer "place"
    t.boolean "is_release_flg", default: false, null: false
    t.boolean "is_login_flg", default: false, null: false
    t.integer "display_order"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holiday_settings", force: :cascade do |t|
    t.date "year"
    t.string "january_holiday"
    t.string "february_holiday"
    t.string "march_holiday"
    t.string "april_holiday"
    t.string "may_holiday"
    t.string "june_holiday"
    t.string "july_holiday"
    t.string "august_holiday"
    t.string "september_holiday"
    t.string "october_holiday"
    t.string "november_holiday"
    t.string "december_holiday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "item"
    t.integer "sitemap_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sitemap_id"], name: "index_items_on_sitemap_id"
  end

  create_table "mail_settings", force: :cascade do |t|
    t.boolean "use_basic_email_flg", default: true, null: false
    t.string "password_reissue_sender"
    t.string "password_reissue_destination"
    t.string "order_change_sender"
    t.string "order_change_destination"
    t.string "shipping_sender"
    t.string "shipping_destination"
    t.string "cancel_sender"
    t.string "cancel_destination"
    t.string "stock_notification_sender"
    t.string "stock_notification_destination"
    t.string "shipment_request_change_sender"
    t.string "shipment_request_change_destination"
    t.string "user_password_reissue_sender"
    t.string "user_password_change_sender"
    t.string "user_thank_you_change_sender"
    t.string "user_shipping_sender"
    t.string "user_cancel_sender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_ranks", force: :cascade do |t|
    t.string "name"
    t.integer "multiplication_rate"
    t.integer "recalculation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
  end

  create_table "order_histories", force: :cascade do |t|
    t.string "order_number"
    t.text "memo"
    t.integer "status"
    t.integer "user_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cart_number"
    t.date "order_date_start"
    t.date "order_date_end"
    t.boolean "preferred_date_flg", default: false, null: false
    t.date "preferred_date_start"
    t.date "preferred_date_end"
    t.string "invoice_number"
    t.integer "payment_method"
    t.integer "payment"
    t.integer "allocation_status"
    t.integer "shipping_status"
    t.boolean "postage_confirmation", default: false, null: false
    t.integer "shipping_origin_id"
    t.boolean "cancel_flg", default: false, null: false
    t.integer "shipment_id"
    t.index ["cart_id"], name: "index_order_histories_on_cart_id"
    t.index ["user_id"], name: "index_order_histories_on_user_id"
  end

  create_table "order_history_products", force: :cascade do |t|
    t.integer "order_history_id"
    t.integer "product_id"
    t.integer "num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_contents", force: :cascade do |t|
    t.string "title"
    t.text "sentence"
    t.integer "free_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_method_settings", force: :cascade do |t|
    t.integer "payment_method"
    t.text "payee_memo"
    t.boolean "cash_on_delivery_charge_flg", default: true, null: false
    t.string "amount_collected_1"
    t.string "cash_on_delivery_charge_1"
    t.string "amount_collected_2"
    t.string "cash_on_delivery_charge_2"
    t.string "amount_collected_3"
    t.string "cash_on_delivery_charge_3"
    t.string "amount_collected_4"
    t.string "cash_on_delivery_charge_4"
    t.string "amount_collected_5"
    t.string "cash_on_delivery_charge_5"
    t.string "amount_collected_6"
    t.string "cash_on_delivery_charge_6"
    t.string "cash_on_delivery_charge_7"
    t.text "cash_on_delivery_charge_memo"
    t.text "deadline_memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postages", force: :cascade do |t|
    t.string "hokkaido"
    t.string "aomori"
    t.string "iwate"
    t.string "miyagi"
    t.string "akita"
    t.string "yamagata"
    t.string "hukushima"
    t.string "ibaragi"
    t.string "totigi"
    t.string "gunma"
    t.string "saitama"
    t.string "chiba"
    t.string "tokyo"
    t.string "kanagawa"
    t.string "nigata"
    t.string "toyama"
    t.string "ishikawa"
    t.string "hukui"
    t.string "yamanashi"
    t.string "nagano"
    t.string "gihu"
    t.string "sizuoka"
    t.string "aichi"
    t.string "mie"
    t.string "shiga"
    t.string "kyoto"
    t.string "osaka"
    t.string "hyogo"
    t.string "nara"
    t.string "wakayama"
    t.string "tottori"
    t.string "shimane"
    t.string "okayama"
    t.string "hiroshima"
    t.string "yamaguchi"
    t.string "tokushima"
    t.string "kagawa"
    t.string "ehime"
    t.string "kochi"
    t.string "hukuoka"
    t.string "saga"
    t.string "nagasaki"
    t.string "kumamoto"
    t.string "oita"
    t.string "kagoshima"
    t.string "okinawa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_pages", force: :cascade do |t|
    t.text "up_page_text"
    t.text "bottom_page_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.integer "category_id"
    t.integer "price"
    t.integer "member_price"
    t.string "product_number"
    t.boolean "postage_flg", default: false, null: false
    t.integer "postage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jan_code"
    t.string "shipping_location"
    t.string "notification_email"
    t.boolean "new_flg", default: true, null: false
    t.boolean "popular_flg", default: true, null: false
    t.text "comment"
    t.text "explanation_1"
    t.text "explanation_2"
    t.boolean "tax_flg", default: true, null: false
    t.string "manufacturer"
    t.boolean "remote_island_shipping_confirmation", default: true, null: false
    t.date "display_period_start"
    t.date "display_period_end"
    t.integer "purchase_limit"
    t.text "postage_comment"
    t.boolean "is_release_flg", default: false, null: false
    t.boolean "set_flg", default: false, null: false
    t.integer "set_num"
    t.integer "shipping_origin_id"
    t.string "shipping_company"
    t.integer "stock_management_id"
  end

  create_table "purchase_histories", force: :cascade do |t|
    t.integer "cart_id"
    t.string "cart_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_history_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.integer "display_order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inquery_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_monthly_holidays", force: :cascade do |t|
    t.date "year_month"
    t.string "set_holidays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipment_products", force: :cascade do |t|
    t.integer "shipment_id"
    t.integer "product_id"
    t.integer "num"
    t.integer "status"
    t.boolean "picking_flg", default: false, null: false
    t.boolean "csv_flg", default: false, null: false
    t.date "expected_shipping_date"
    t.date "ship_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_number"
    t.boolean "shipping_email_flg", default: false, null: false
    t.date "billing_date"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "shipping_status"
    t.integer "allocation_status"
    t.date "expected_shipping_date"
    t.integer "shipping_company"
    t.date "ship_date"
    t.boolean "shipping_email", default: false, null: false
    t.date "billing_date"
    t.date "sales_record_date"
    t.integer "data_download"
    t.boolean "total_picking", default: false, null: false
    t.boolean "individual_picking", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_history_id"
    t.boolean "cancel_flg", default: false, null: false
    t.integer "shipping_origin_id"
    t.integer "prefectures"
    t.date "order_date"
    t.date "preferred_arrival_date"
    t.boolean "arrival_date_flg", default: false, null: false
    t.boolean "expected_shipping_date_flg", default: false, null: false
    t.boolean "sales_record_date_flg", default: false, null: false
  end

  create_table "shipping_origins", force: :cascade do |t|
    t.integer "status"
    t.string "origin_id"
    t.string "password_digest"
    t.string "shipping_origin_name"
    t.string "shipping_origin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_settings", force: :cascade do |t|
    t.string "free_shipping_service"
    t.integer "basic_setting"
    t.string "nationwide_rate"
    t.string "same_shipping_rate_setting"
    t.integer "postage_id"
    t.integer "postage_consumption_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_holidays", force: :cascade do |t|
    t.boolean "calendar_display_flg", default: true, null: false
    t.boolean "sunday_break", default: true, null: false
    t.boolean "monday_break", default: false, null: false
    t.boolean "tuesday_break", default: false, null: false
    t.boolean "wednesday_break", default: false, null: false
    t.boolean "thursday_break", default: false, null: false
    t.boolean "friday_break", default: false, null: false
    t.boolean "saturday_break", default: true, null: false
    t.boolean "holiday_setting", default: true, null: false
    t.text "comment"
    t.integer "set_monthly_holiday_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.boolean "open_flg", default: true, null: false
    t.string "logo"
    t.string "name"
    t.string "company_name"
    t.string "zip_code"
    t.integer "prefectures"
    t.string "municipation"
    t.string "address_1"
    t.string "address_2"
    t.string "tel"
    t.string "fax"
    t.string "email"
    t.integer "stock_notification_num"
    t.integer "payment_method"
    t.string "billing_customer_code"
    t.integer "product_name_setting"
    t.string "name_set"
    t.integer "start_condition"
    t.boolean "shipped_flg", default: true, null: false
    t.boolean "set_shipping_company_flg", default: true, null: false
    t.integer "product_consumption_tax_flg"
    t.integer "tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sitemaps", force: :cascade do |t|
    t.string "map_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_fluctuations", force: :cascade do |t|
    t.integer "stock"
    t.integer "allocate"
    t.boolean "unlimited_flg", default: false, null: false
    t.integer "stock_management_id"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
  end

  create_table "stock_managements", force: :cascade do |t|
    t.integer "stock"
    t.integer "allocate"
    t.boolean "unlimited_flg", default: false, null: false
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "e_mail"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_token"
    t.string "company_name"
    t.string "department_name"
    t.string "phone_number"
    t.string "member_code"
    t.text "remark"
    t.integer "status"
    t.integer "rank"
    t.string "name_sei"
    t.string "name_mei"
    t.string "name_sei_kana"
    t.string "name_mei_kana"
    t.string "zip_code"
    t.integer "prefectures"
    t.string "municipation"
    t.string "address_1"
    t.string "address_2"
    t.string "tel"
    t.string "fax"
    t.integer "payment_method"
    t.string "company_name_kana"
    t.string "company_code"
    t.string "department_name_kana"
    t.string "department_code"
    t.string "member_id"
    t.boolean "deadline", default: false, null: false
    t.index ["cart_id"], name: "index_users_on_cart_id"
  end

end
