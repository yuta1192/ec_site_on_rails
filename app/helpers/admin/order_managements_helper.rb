module Admin::OrderManagementsHelper
  # selectboxの中身
  def payment_method
    a = [['指定なし',99],['銀行振込',1],['代金引換',2],['締め払い',3]]
    return a
  end

  def payment
    a = [['指定なし',99],['入金待ち',1],['済+確認不要',2]]
    return a
  end

  def postage_confirmation
    a = [['指定なし',99],['要確認',1],['確認済/確認不要',2]]
    return a
  end

  def shipping_origin
    a = [['指定なし',99],['自社',1],['丸々物流',2],['罰罰財閥',3]]
    return a
  end

  def cancel
    a = [['指定なし',99],['あり',1],['なし',2]]
    return a
  end

  def order_display
    a = [['指定なし',99],['日付順',1],['担当者名順',2],['決済方式順',3],['出荷日付順',4]]
    return a
  end

  # 検索内容の表示
  def search_order_number
    params[:order_history][:order_number].present? ? params[:order_history][:order_number] : "指定なし"
  end

  def search_payment_method
    if params[:order_history][:payment_method] == "1"
      "銀行振込"
    elsif params[:order_history][:payment_method] == "2"
      "代金引換"
    elsif params[:order_history][:payment_method] == "3"
      "締め払い"
    else
      "指定なし"
    end
  end

  def search_invoice_number
    params[:order_history][:invoice_number].present? ? params[:order_history][:invoice_number] : "指定なし"
  end

  def search_payment
    if params[:order_history][:payment] == "1"
      "入金待ち"
    elsif params[:order_history][:payment] == "2"
      "済+確認不要"
    else
      "指定なし"
    end
  end

  def search_order_date
    if params[:order_history][:order_start_date].present? && params[:order_history][:order_end_date].present?
      "#{params[:order_history][:order_start_date]}~#{params[:order_history][:order_end_date]}"
    elsif params[:order_history][:order_start_date].present? && params[:order_history][:order_end_date].blank?
      "#{params[:order_history][:order_start_date]}~"
    elsif params[:order_history][:order_start_date].blank? && params[:order_history][:order_end_date].present?
      "~#{params[:order_history][:order_end_date]}"
    else
      "指定なし"
    end
  end

  def search_preferred_date
    if params[:order_history][:preferred_date] == "1"
      if params[:order_history][:order_preferred_start_date].present? && params[:order_history][:order_preferred_end_date].present?
        "期間指定 #{params[:order_history][:order_preferred_start_date]}~#{params[:order_history][:order_preferred_end_date]}"
      elsif params[:order_history][:order_preferred_start_date].present? && params[:order_history][:order_preferred_end_date].blank?
        "期間指定 #{params[:order_history][:order_preferred_start_date]}~"
      elsif params[:order_history][:order_preferred_start_date].blank? && params[:order_history][:order_preferred_end_date].present?
        "期間指定 ~#{params[:order_history][:order_preferred_end_date]}"
      else
        "指定なし"
      end
    elsif params[:order_history][:preferred_date] == "2"
      "未入力のみ"
    elsif params[:order_history][:preferred_date] == "3"
      "入力済みのみ"
    end
  end

  def search_product_number
    params[:order_history][:product_number].present? ? params[:order_history][:product_number] : "指定なし"
  end

  def search_product_name
    params[:order_history][:product_name].present? ? params[:order_history][:product_name] : "指定なし"
  end

  def search_manufacturer
    params[:order_history][:manufacturer].present? ? params[:order_history][:manufacturer] : "指定なし"
  end

  def search_company_name
    params[:order_history][:company_name].present? ? params[:order_history][:company_name] : "指定なし"
  end

  def search_department_code
    params[:order_history][:department_code].present? ? params[:order_history][:department_code] : "指定なし"
  end

  def search_department_name
    params[:order_history][:department_name].present? ? params[:order_history][:department_name] : "指定なし"
  end

  def search_member_code
    params[:order_history][:member_code].present? ? params[:order_history][:member_code] : "指定なし"
  end

  def search_contact_name
    params[:order_history][:contact_name].present? ? params[:order_history][:contact_name] : "指定なし"
  end

  def search_tel
    params[:order_history][:tel].present? ? params[:order_history][:tel] : "指定なし"
  end

  def search_mail_address
    params[:order_history][:mail_address].present? ? params[:order_history][:mail_address] : "指定なし"
  end

  def search_postage_confirmation
    if params[:order_history][:postage_confirmation] == "1"
      "要確認"
    elsif params[:order_history][:postage_confirmation] == "2"
      "確認済/確認不要"
    else
      "指定なし"
    end
  end

  def search_shipping_origin
    if params[:order_history][:shipping_origin] == "1"
      "自社"
    elsif params[:order_history][:shipping_origin] == "2"
      "丸々物流"
    elsif params[:order_history][:shipping_origin] == "3"
      "罰罰財閥"
    else
      "指定なし"
    end
  end

  def search_cancel
    if params[:order_history][:cancel] == "1"
      "あり"
    elsif params[:order_history][:cancel] == "2"
      "なし"
    else
      "指定なし"
    end
  end

  def search_order_display
    if params[:order_history][:order_display] == "1"
      "日付順"
    elsif params[:order_history][:order_display] == "2"
      "担当者名順"
    elsif params[:order_history][:order_display] == "3"
      "決済方式順"
    elsif params[:order_history][:order_display] == "4"
      "出荷日付順"
    else
      "指定なし"
    end
  end

  def allocation_status
    status = []
    status << "未引当" if params[:order_history][:unallocated] == "true"
    status << "一部引当済" if params[:order_history][:partially_reserved] == "true"
    status << "引当済" if params[:order_history][:allocated] == "true"
    if status.blank?
      return "指定なし"
    else
      return status.join('、')
    end
  end

  def shipping_status
    status = []
    status << "未処理" if params[:order_history][:untreated] == "true"
    status << "出荷可能" if params[:order_history][:can_be_shipped] == "true"
    status << "着手" if params[:order_history][:undertake] == "true"
    status << "出荷済" if params[:order_history][:shipped] == "true"
    if status.blank?
      return "指定なし"
    else
      return status.join('、')
    end
  end
end
