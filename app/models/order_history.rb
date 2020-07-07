class OrderHistory < ApplicationRecord
  belongs_to :user
  has_one :purchase_history
  has_one :delivery_info
  has_many :cart_items

  scope :search, -> (search_params) do
    return if search_params.blank?

    order_start_date(search_params[:order_start_date])
      .order_end_date(search_params[:order_end_date])
      .order_preferred_start_date(search_params[:order_preferred_start_date])
      .order_preferred_end_date(search_params[:order_preferred_end_date])
      .preferred_date(search_params[:preferred_date])
      .unspecified(search_params[:unspecified])
      .order_number(search_params[:order_number])
      .product_number(search_params[:product_number])
      .product_name(search_params[:product_name])
      .new_product(search_params[:new_product])
      .popular_product(search_params[:popular_product])
      .manufacturer(search_params[:manufacturer])
      .invoice_number(search_params[:invoice_number])
      .company_name(search_params[:company_name])
      .department_code(search_params[:department_code])
      .department_name(search_params[:department_name])
      .member_code(search_params[:member_code])
      .tel(search_params[:tel])
      .mail_address(search_params[:mail_address])
      .payment_method(search_params[:payment_method])
      .payment(search_params[:payment])
      .allocation_status(search_params[:unallocated], search_params[:partially_reserved], search_params[:allocated])
      .shipping_status(search_params[:untreated], search_params[:can_be_shipped], search_params[:undertake], search_params[:shipped])
      .postage_confirmation(search_params[:postage_confirmation])
      .shipping_origin(search_params[:shipping_origin])
      .cancel(search_params[:cancel])
  end

  scope :order_start_date, -> start { where('? <= created_at', start) if start.present? }
  scope :order_end_date, -> the_end { where('created_at <= ?', the_end) if the_end.present? }
  scope :preferred_date, -> preferred {
    if preferred == "1"
      return # 1ならお届け希望日の範囲から取得
    elsif preferred == "2"
      where()
    elsif preferred == "3"
      where()
    end
  }
  # preferred == "1"の時だけ
  scope :order_preferred_start_date, -> start { where('? <= created_at', start) if start.present? && search_params[:preferred_date] == 1 }
  scope :order_preferred_end_date, -> the_end { where('? <= created_at', the_end) if the_end.present?  && search_params[:preferred_date] == 1 }
  scope :unspecified, -> unspecified { return if unspecified == "false" } #falseなら未指定は含まない
  scope :order_number, -> order_number { where('order_number LIKE ?', "%#{order_number}%") if order_number.present? }
  scope :product_number, -> product_number { where('product_number LIKE ?', "%#{product_number}%") if product_number.present? }
  scope :product_name, -> product_name { where('product_name LIKE ?', "%#{product_name}%") if product_name.present? }
  scope :new_product, -> new_product { where() if new_product == "true" }
  scope :popular_product, -> popular_product { where() if popular_product == "true" }
  scope :manufacturer, -> manufacturer { where('manufacturer LIKE ?', "%#{manufacturer}%") if manufacturer.present? }
  scope :invoice_number, -> invoice_number { where('invoice_number LIKE ?', "%#{invoice_number}%") if invoice_number.present? }
  scope :company_name, -> company_name { where('company_name LIKE ?', "%#{company_name}%") if company_name.present? }
  scope :department_code, -> department_code { where('department_code LIKE ?', "%#{department_code}%") if department_code.present? }
  scope :department_name, -> department_name { where('department_name LIKE ?', "%#{department_name}%") if department_name.present? }
  scope :member_code, -> member_code { where('member_code LIKE ?', "%#{member_code}%") if member_code.present? }
  scope :tel, -> tel { where('tel LIKE ?', "%#{tel}%") if tel.present? }
  scope :mail_address, -> mail_address { where('mail_address LIKE ?', "%#{mail_address}%") if mail_address.present? }
  scope :payment_method, -> payment_method {
    if payment_method == "99"
      return
    elsif payment_method == "1"
      where()
    elsif payment_method == "2"
      where()
    elsif payment_method == "3"
      where()
    end
  }
  scope :payment, -> payment {
    if payment == "99"
      return
    elsif payment == "1"
      where()
    elsif payment == "2"
      where()
    end
  }
  scope :allocation_status, -> unallocated, partially_reserved, allocated {
    if unallocated == "true" && partially_reserved == "true" && allocated == "true"
      return # 指定なし
    elsif unallocated == "true" && partially_reserved == "true" && allocated == "false"
      where()
    elsif unallocated == "true" && partially_reserved == "false" && allocated == "true"
      where()
    elsif unallocated == "false" && partially_reserved == "true" && allocated == "true"
      where()
    elsif unallocated == "true" && partially_reserved == "false" && allocated == "false"
      where()
    elsif unallocated == "false" && partially_reserved == "true" && allocated == "false"
      where()
    elsif unallocated == "false" && partially_reserved == "false" && allocated == "true"
      where()
    elsif unallocated == "false" && partially_reserved == "false" && allocated == "false"
      return
    end
  }
  scope :shipping_status, -> untreated, can_be_shipped, undertake, shipped {
    if untreated == "true" && can_be_shipped == "true" && undertake == "true" && shipped == "true"
      return # 指定なし
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "true" && shipped == "false"
      where()
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "false" && shipped == "true"
      where()
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "true" && shipped == "true"
      where()
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "true" && shipped == "true"
      where()
    elsif untreated == "true" && can_be_shipped == "true" && undertake == "false" && shipped == "false"
      where()
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "true" && shipped == "false"
      where()
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "true" && shipped == "false"
      where()
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "false" && shipped == "true"
      where()
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "false" && shipped == "true"
      where()
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "true" && shipped == "true"
      where()
    elsif untreated == "true" && can_be_shipped == "false" && undertake == "false" && shipped == "false"
      where()
    elsif untreated == "false" && can_be_shipped == "true" && undertake == "false" && shipped == "false"
      where()
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "true" && shipped == "false"
      where()
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "false" && shipped == "true"
      where()
    elsif untreated == "false" && can_be_shipped == "false" && undertake == "false" && shipped == "false"
      return
    end
  }
  scope :postage_confirmation, -> postage_confirmation {
    if postage_confirmation == "99"
      return # 指定なし
    elsif postage_confirmation == "1"
      where()
    elsif postage_confirmation == "2"
      where()
    end
  }
  scope :shipping_origin, -> shipping_origin {
    if shipping_origin == "99"
      return # 指定なし
    elsif shipping_origin == "1"
      where()
    elsif shipping_origin == "2"
      where()
    elsif shipping_origin == "3"
      where()
    end
  }
  scope :cancel, -> cancel {
    if cancel == "99"
      return # 指定なし
    elsif cancel == "1"
      where()
    elsif cancel == "2"
      where()
    end
  }
end
