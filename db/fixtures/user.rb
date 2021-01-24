# randamな文字取得
require 'securerandom'

# userを10個作成
10.times do |i|
  User.seed do |s|
    s.id = i+1
    s.e_mail = "sample#{i+1}@gmail.com"
    s.password = "password"
    s.remember_token = SecureRandom.urlsafe_base64
    s.company_name = "company#{i+1}"
    s.department_name = "department#{i+1}"
    s.phone_number = "000-0000-00#{i}"
    s.member_code = "#{i+1}"
    s.remark = nil
    s.status = 1
    s.rank = 1
    s.name_sei = "sei#{i+1}"
    s.name_mei = "mei#{i+1}"
    s.name_sei_kana = "セイ#{i+1}"
    s.name_mei_kana = "メイ#{i+1}"
    s.zip_code = "000-0000"
    s.prefectures = i+1
    s.municipation = "弥生"
    s.address_1 = "あいウロ"
    s.address_2 = "1-1-#{i+1}"
    s.tel = "0120-00-0000"
    s.fax = "0120-00-0000"
    s.payment_method = 1
    s.company_name_kana = "会社#{i+1}"
    s.company_code = "#{i+1}"
    s.department_name_kana = "デパートメント#{i+1}"
    s.department_code = "#{i+1}"
    s.member_id = "#{i+1}"
    s.deadline = true
    s.admin = false
  end

  Cart.seed do |c|
    c.id = i+1
    c.cart_number = SecureRandom.alphanumeric(10)
    c.user_id = i+1
  end
end

# 住所を数個登録
5.times do |p|
  Address.seed do |a|
    a.company_name = SecureRandom.alphanumeric()
    a.department_name = SecureRandom.alphanumeric()
    a.name_sei = SecureRandom.alphanumeric(5)
    a.name_mei = SecureRandom.alphanumeric(5)
    a.name_sei_kana = "サンプル#{p}"
    a.name_mei_kana = "サンプル#{p}"
    a.zip_code = "999-0000"
    a.prefectures = rand(1..47)
    a.municipation = SecureRandom.alphanumeric()
    a.address_1 = SecureRandom.alphanumeric()
    a.address_2 = SecureRandom.alphanumeric()
    a.tel = "000-0000-0000"
    a.phone_number = "0120-00-0000"
    a.user_id = rand(1..10)
    if p == 1
      a.is_select_flag = true
    else
      a.is_select_flag = false
    end
    a.company_code = SecureRandom.alphanumeric()
    a.department_code = SecureRandom.alphanumeric()
    a.fax = "0120-00-0000"
    a.delivery_id = p+1
  end
end
