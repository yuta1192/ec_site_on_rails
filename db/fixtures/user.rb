# userを10個作成
10.times do |i|
  User.seed do |s|
    s.id = i+1
    s.e_mail = "sample#{i+1}@gmail.com"
    s.cart_id = nil
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
end
