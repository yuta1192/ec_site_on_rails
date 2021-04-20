# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create!(
  name: "商品A",
  category_id: 1,
  price: 1000,
  member_price: 900,
  stock: 100,
  product_number: "original1000",
  postage_flg: true,
  postage: 1000,
  jan_code: "jancode_1",
  shipping_location: "青森県",
  notification_email: "abababa@sackle.com",
  new_flg: true,
  popular_flg: true,
  comment: "コメントを挿入してください",
  explanation_1: "説明文１であります",
  explanation_2: "説明文2であります",
  tax_flg: true,
  manufacturer: "日本製マルボロ",
  remote_island_shipping_confirmation: true,
  display_period_start: Date.today,
  display_period_end: Date.today,
  purchase_limit: 10,
  postage_comment: "送料コメントよろしく",
  is_release_flg: true
)

Product.create!(
  name: "商品BBBBBBBB",
  category_id: 2,
  price: 3000,
  member_price: 100,
  stock: 100,
  product_number: "original8000",
  postage_flg: true,
  postage: 1000,
  jan_code: "jancode_1",
  shipping_location: "青森県",
  notification_email: "abababa@sackle.com",
  new_flg: true,
  popular_flg: true,
  comment: "コメントを挿入してください",
  explanation_1: "説明文１であります",
  explanation_2: "説明文2であります",
  tax_flg: true,
  manufacturer: "日本製マルボロ",
  remote_island_shipping_confirmation: true,
  display_period_start: Date.today,
  display_period_end: Date.today,
  purchase_limit: 10,
  postage_comment: "送料コメントよろしく",
  is_release_flg: true
)
