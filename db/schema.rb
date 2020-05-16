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

ActiveRecord::Schema.define(version: 2020_05_16_032906) do

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
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.string "cart_number"
    t.integer "cart_id"
    t.integer "order_history_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_carts_on_cart_id"
    t.index ["order_history_id"], name: "index_carts_on_order_history_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.text "contact"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "free_pages", force: :cascade do |t|
    t.string "title"
    t.string "second_title"
    t.text "sentence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "information", force: :cascade do |t|
    t.text "detail"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inqueries", force: :cascade do |t|
    t.text "question"
    t.text "answer"
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

  create_table "order_histories", force: :cascade do |t|
    t.string "order_number"
    t.text "memo"
    t.integer "status"
    t.integer "user_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_order_histories_on_cart_id"
    t.index ["user_id"], name: "index_order_histories_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.integer "category"
    t.integer "child_category"
    t.integer "price"
    t.integer "member_price"
    t.integer "stock"
    t.string "product_number"
    t.boolean "postage_flg", default: false, null: false
    t.integer "postage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["cart_id"], name: "index_users_on_cart_id"
  end

end
