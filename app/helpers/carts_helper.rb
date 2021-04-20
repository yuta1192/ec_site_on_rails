module CartsHelper
  def data_select_box
    # お届け日のセレクトの部分作成
    date_select = [['指定なし',99]]
    # current_date = Date.today.strftime("%Y/%m/%d/")
    (0..10).each do |i|
      date_select << [(Date.today+(i+5)).strftime("%Y/%m/%d"), i]
    end
    return date_select
  end

  def user_address_select
    # お届け先のセレクトボックス作成
    addresses_name = [['新規お届け先',0]]
    @current_user.addresses.each do |address|
      addresses_name << [address.company_name, address.id]
    end
    return addresses_name
  end
end
