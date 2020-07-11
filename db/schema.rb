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

ActiveRecord::Schema.define(version: 2020_07_08_092142) do

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

  create_table "Products", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.string "category_name"
    t.integer "category_id"
    t.integer "price"
    t.integer "member_price"
    t.integer "stock"
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
  end

  create_table "addresses", force: :cascade do |t|
    t.string "company_name"
    t.string "department_name"
    t.string "name_sei"
    t.string "name_mei"
    t.string "name_sei_kana"
    t.string "name_mei_kana"
    t.integer "zip_code"
    t.integer "prefectures"
    t.string "municipation"
    t.string "address_1"
    t.string "address_2"
    t.integer "tel"
    t.integer "phone_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_select_flag", default: false, null: false
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

  create_table "items", force: :cascade do |t|
    t.string "item"
    t.integer "sitemap_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sitemap_id"], name: "index_items_on_sitemap_id"
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
    t.integer "shipping_origin"
    t.boolean "cancel_flg", default: false, null: false
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

  create_table "product_pages", force: :cascade do |t|
    t.text "up_page_text"
    t.text "bottom_page_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "sitemaps", force: :cascade do |t|
    t.string "map_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "e_mail"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_token"
    t.string "company_name"
    t.string "department_name"
    t.string "contact_name"
    t.integer "phone_number"
    t.index ["cart_id"], name: "index_users_on_cart_id"
  end

end
