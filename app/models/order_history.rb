class OrderHistory < ApplicationRecord
  # 注文履歴
  # status 1:出荷前、2:出荷中、3:出荷済
  # payment_method 1:締め払い、2:その店毎の設定した払い日
  # 1:入金待ち、2:済+確認不要
  # preferred_date_flg お届け希望日 false:希望なし, true:希望あり
  # preferred_date_start/end 上記がtrueの場合希望日

  belongs_to :user
  # has_one :purchase_history
  has_one :delivery_info
  has_many :cart_items
  has_many :order_history_products
  has_many :products, through: :order_history_products
  belongs_to :address
  belongs_to :shipment, optional: true

  scope :search, -> (search_params) do
    return if search_params.blank?

    order_date_start_search(search_params[:order_date_start])
      .order_date_end_search(search_params[:order_date_end])
      .order_preferred_date_start_search(search_params[:order_preferred_date_start])
      .order_preferred_date_end_search(search_params[:order_preferred_date_end])
      .preferred_date_search(search_params[:preferred_date])
      .unspecified_search(search_params[:unspecified])
      .order_number_search(search_params[:order_number])
      .product_number_search(search_params[:product_number])
      .product_name_search(search_params[:product_name])
      .new_product_search(search_params[:new_product])
      .popular_product_search(search_params[:popular_product])
      .manufacturer_search(search_params[:manufacturer])
      .invoice_number_search(search_params[:invoice_number])
      .company_name_search(search_params[:company_name])
      .department_code_search(search_params[:department_code])
      .department_name_search(search_params[:department_name])
      .member_code_search(search_params[:member_code])
      .tel_search(search_params[:tel])
      .mail_address_search(search_params[:mail_address])
      .payment_method_search(search_params[:payment_method])
      .payment_search(search_params[:payment])
      .allocation_status_search(search_params[:unallocated], search_params[:partially_reserved], search_params[:allocated])
      .shipping_status_search(search_params[:untreated], search_params[:can_be_shipped], search_params[:undertake], search_params[:shipped])
      .postage_confirmation_search(search_params[:postage_confirmation])
      .shipping_origin_search(search_params[:shipping_origin])
      .cancel_search(search_params[:cancel])
      .memo_search(search_params[:memo])
  end

  scope :order_date_start_search, -> start { where('? <= order_date_start', start) if start.present? }
  scope :order_date_end_search, -> the_end { where('order_date_end <= ?', the_end) if the_end.present? }
  scope :preferred_date_search, -> preferred {
    if preferred == "1"
      all # 1ならお届け希望日の範囲から取得
    elsif preferred == "2"
      where(preferred_date_flg: false)
    elsif preferred == "3"
      where(preferred_date_flg: true)
    end
  }
  # preferred == "1"の時だけ
  scope :order_preferred_date_start_search, -> start_date { where('? <= preferred_date_start', start_date) if start_date.present? && search_params[:preferred_date] == 1 }
  scope :order_preferred_date_end_search, -> end_date { where('preferred_date_end <= ?', end_date) if end_date.present?  && search_params[:preferred_date] == 1 }
  scope :unspecified_search, -> unspecified { all if unspecified == "false" } #falseなら未指定は含まない
  scope :order_number_search, -> order_number { where('order_number LIKE ?', "%#{order_number}%") if order_number.present? }
  scope :product_number_search, -> product_number { where('products.product_number LIKE ?', "%#{product_number}%") if product_number.present? }
  scope :product_name_search, -> product_name { where('products.name LIKE ?', "%#{product_name}%") if product_name.present? }
  scope :new_product_search, -> new_product { new_product == "true" ? where(products: {new_flg: true}) : where(products: {popular_flg: false}) }
  scope :popular_product_search, -> popular_product {
    popular_product == "true" ? where(products: {popular_flg: true}) : where(products: {popular_flg: false})
  }
  scope :manufacturer_search, -> manufacturer { where('products.manufacturer LIKE ?', "%#{manufacturer}%") if manufacturer.present? }
  scope :invoice_number_search, -> invoice_number { where('invoice_number LIKE ?', "%#{invoice_number}%") if invoice_number.present? }
  scope :company_name_search, -> company_name { where('addresses.company_name LIKE ?', "%#{company_name}%") if company_name.present? }
  scope :department_code_search, -> department_code { where('addresses.department_code LIKE ?', "%#{department_code}%") if department_code.present? }
  scope :department_name_search, -> department_name { where('addresses.department_name LIKE ?', "%#{department_name}%") if department_name.present? }
  scope :member_code_search, -> member_code { where('users.member_code LIKE ?', "%#{member_code}%") if member_code.present? }
  scope :tel_search, -> tel { where('users.phone_number LIKE ?', "%#{tel}%") if tel.present? }
  scope :mail_address_search, -> mail_address { where('users.e_mail LIKE ?', "%#{mail_address}%") if mail_address.present? }
  scope :payment_method_search, -> payment_method {
    if payment_method == "99"
      all
    else
      where(payment_method: payment_method)
    end
  }
  scope :payment_search, -> payment {
    if payment == "99"
      all
    else
      where(payment: payment)
    end
  }
  scope :allocation_status_search, -> unallocated, partially_reserved, allocated {
    if unallocated == "true" && partially_reserved == "true" && allocated == "true"
      all # 指定なし
    elsif unallocated == "true" && partially_reserved == "true" && allocated == "false"
      where(allocation_status: [1,2])
    elsif unallocated == "true" && partially_reserved == "false" && allocated == "true"
      where(allocation_status: [1,3])
    elsif unallocated == "false" && partially_reserved == "true" && allocated == "true"
      where(allocation_status: [2,3])
    elsif unallocated == "true" && partially_reserved == "false" && allocated == "false"
      where(allocation_status: 1)
    elsif unallocated == "false" && partially_reserved == "true" && allocated == "false"
      where(allocation_status: 2)
    elsif unallocated == "false" && partially_reserved == "false" && allocated == "true"
      where(allocation_status: 3)
    elsif unallocated == "false" && partially_reserved == "false" && allocated == "false"
      where(allocation_status: nil)
    end
  }
  scope :shipping_status_search, -> untreated, can_be_shipped, undertake, shipped {
    if untreated == "true" && can_be_shipped == "true" && undertake == "true" && shipped == "true"
      all # 指定なし
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "true" && shipped == "false"
      where(shipping_status: [1,2,3])
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "false" && shipped == "true"
      where(shipping_status: [1,2,4])
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "true" && shipped == "true"
      where(shipping_status: [1,3,4])
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "true" && shipped == "true"
      where(shipping_status: [2,3,4])
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "false" && shipped == "false"
      where(shipping_status: [1,2])
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "true" && shipped == "false"
      where(shipping_status: [1,3])
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "true" && shipped == "false"
      where(shipping_status: [2,3])
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "false" && shipped == "true"
      where(shipping_status: [1,4])
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "false" && shipped == "true"
      where(shipping_status: [2,4])
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "true" && shipped == "true"
      where(shipping_status: [3,4])
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "false" && shipped == "false"
      where(shipping_status: 1)
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "false" && shipped == "false"
      where(shipping_status: 2)
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "true" && shipped == "false"
      where(shipping_status: 3)
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "false" && shipped == "true"
      where(shipping_status: 4)
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "false" && shipped == "false"
      where(shipping_status: nil)
    end
  }
  scope :postage_confirmation_search, -> postage_confirmation {
    if postage_confirmation == "99"
      all # 指定なし
    else
      where(postage_confirmation: postage_confirmation)
    end
  }
  scope :shipping_origin_search, -> shipping_origin {
    if shipping_origin == "99"
      all # 指定なし
    else
      where(shipping_origin: shipping_origin)
    end
  }
  scope :cancel_search, -> cancel {
    if cancel == "99"
      all # 指定なし
    else
      where(cancel_flg: cancel)
    end
  }
  scope :memo_search, -> memo { where('memo LIKE ?', "%#{memo}%") if memo.present? }

  scope :range_current_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }
  scope :range_yesterday, -> { where(created_at: Time.current.yesterday.beginning_of_day..Time.current.yesterday.end_of_day) }
  scope :range_today, -> { where(created_at: Time.current.beginning_of_day..Time.current.end_of_day) }
end
