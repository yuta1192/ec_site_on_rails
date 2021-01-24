module OrderHistoriesHelper
  def select_cancel_flg
    select = [['あり', true],['なし', false]]
    select.unshift(['指定なし',99])
  end

  def order_count
    count = @order_query.present? ? @order_query.count : 0
    return count
  end

  def start_dates
    date = "#{params[:order_history]["start_date(1i)"]}年#{params[:order_history]["start_date(2i)"]}月#{params[:order_history]["start_date(3i)"]}日"
    return date
  end

  def end_dates
    date = "#{params[:order_history]["end_date(1i)"]}年#{params[:order_history]["end_date(2i)"]}月#{params[:order_history]["end_date(3i)"]}日"
    return date
  end

  def params_order_number
    order_number = params[:order_history][:order_number].present? ? "#{params[:order_history][:order_number]}" : "指定なし"
    return order_number
  end

  def params_product_number
    product_number = params[:order_history][:product_number].present? ? "#{params[:order_history][:product_number]}" : "指定なし"
    return product_number
  end

  def params_product_name
    product_name = params[:order_history][:product_name].present? ? "#{params[:order_history][:product_name]}" : "指定なし"
    return product_name
  end

  def params_category
    return "指定なし" unless @categories.present?

    categories = [params[:order_history][:category_1], params[:order_history][:category_2], params[:order_history][:category_3]].uniq!
    category = categories.joins(',')
    return category
  end

  def params_memo
    memo = params[:order_history][:memo].present? ? "#{params[:order_history][:memo]}" : "指定なし"
    return memo
  end

  def params_cancel
    if params[:order_history][:cancel_flg] == "true"
      cancel_flg = "あり"
    elsif params[:order_history][:cancel_flg] == "true"
      cancel_flg = "なし"
    else
      cancel_flg = "指定なし"
    end
    return cancel_flg
  end
end
