module Admin::ShipmentsHelper
  # selectboxの中身
  def shipping_origin
    a = [['指定なし',99],['自社',1],['丸々物流',2],['罰罰財閥',3]]
    return a
  end

  def cancel
    a = [['指定なし',99],['あり',1],['なし',2]]
    return a
  end

  def order_display
    a = [['指定なし',99],['日付順',1],['担当者名順',2],['お届け先 - お名前順',3],['お届け先 - お名前降順',4],['お届け先 - 住所順',5],['お届け先 - 住所降順',6],['決済方式順',7],['入金日付順',8],['出荷日付順',9]]
    return a
  end

  def data_download
    a = [['指定なし',99],['未処理',1],['大和B2済み',2],['出荷CSV済み',3]]
    return a
  end

  def total_picking
    a = [['指定なし',99],['未処理',1],['済み',2]]
    return a
  end

  def individual_picking
    a = [['指定なし',99],['未処理',1],['済み',2]]
    return a
  end


  # viewの検索結果を整形

  def preferred_arrival_date_result
    result =  nil
    if params[:shipment]
      if params[:shipment][:preferred_arrival_date] == "1" && (params[:shipment][:preferred_arrival_start_date].present? || params[:shipment][:preferred_arrival_end_date].present?)
        result =  "お届け希望日 ： #{params[:shipment][:preferred_arrival_start_date]} ~ #{params[:shipment][:preferred_arrival_end_date]} #{params[:shipment][:preferred_arrival_unspecified] == "true" ? "※未入力を含む" : "" }"
      elsif params[:shipment][:preferred_arrival_date] == "2"
        result = "お届け希望日 ： 未入力のみ"
      elsif params[:shipment][:preferred_arrival_date] == "3"
        result = "お届け希望日 ： 入力済みのみ"
      end
    end
    return result
  end

  def untreated_result
    result = nil
    if params[:shipment][:untreated] == "true" && params[:shipment][:can_be_shipped] == "true" && params[:shipment][:undertake] == "true" && params[:shipment][:shipped] == "true"
      result =  "出荷状況 ： 未処理、出荷可能、着手、出荷済"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:can_be_shipped] == "true" && params[:shipment][:undertake] == "true"
      result = "出荷状況 ： 未処理、出荷可能、着手"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:can_be_shipped] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 未処理、出荷可能、出荷済"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:undertake] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 未処理、着手、出荷済"
    elsif params[:shipment][:can_be_shipped] == "true" && params[:shipment][:undertake] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 出荷可能、着手、出荷済"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:can_be_shipped] == "true"
      result = "出荷状況 ： 未処理、出荷可能"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:undertake] == "true"
      result = "出荷状況 ： 未処理、着手"
    elsif params[:shipment][:untreated] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 未処理、出荷済"
    elsif params[:shipment][:can_be_shipped] == "true" && params[:shipment][:undertake] == "true"
      result = "出荷状況 ： 出荷可能、着手"
    elsif params[:shipment][:can_be_shipped] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 出荷可能、出荷済"
    elsif params[:shipment][:undertake] == "true" && params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 着手、出荷済"
    elsif params[:shipment][:untreated] == "true"
      result = "出荷状況 ： 未処理"
    elsif params[:shipment][:can_be_shipped] == "true"
      result = "出荷状況 ： 出荷可能"
    elsif params[:shipment][:undertake] == "true"
      result = "出荷状況 ： 着手"
    elsif params[:shipment][:shipped] == "true"
      result = "出荷状況 ： 出荷済"
    end
    return result
  end

  def sales_record_date_result
    result = nil
    if params[:shipment][:sales_record_date] == "1" && (params[:shipment][:sales_record_start_date].present? || params[:shipment][:sales_record_end_date].present?)
      result = "売上計上日 ： #{params[:shipment][:sales_record_start_date]} ~ #{params[:shipment][:sales_record_end_date]} #{params[:shipment][:sales_record_date_unspecified] == "true" ? "※ 力を含む" : "" }"
    elsif params[:shipment][:sales_record_date] == "2"
      result = "売上計上日 ： 未入力のみ"
    elsif params[:shipment][:sales_record_date] == "3"
      result = "売上計上日 ： 入力済みのみ"
    end
    return result
  end

  def ship_date_result
    result = nil
    if params[:shipment][:ship_start_date].present? || params[:shipment][:ship_end_date].present?
      result = "売上計上日 ： #{params[:shipment][:ship_start_date]} ~ #{params[:shipment][:ship_end_date]}"
    end
    return result
  end

  def download_result
    result = nil
    if params[:shipment][:download] == "1"
      result = "データダウンロード ： 未処理"
    elsif params[:shipment][:download] == "2"
      result = "データダウンロード ： 大和B2済み"
    elsif params[:shipment][:download] == "3"
      result = "データダウンロード ： 出荷CSV済み"
    end
    return result
  end

  def individual_picking_result
    result = nil
    if params[:shipment][:individual_picking] == "1"
      result = "個別ピッキング ： 未処理"
    elsif params[:shipment][:individual_picking] == "2"
      result = "個別ピッキング ： 済み"
    end
    return result
  end

  def cancel_result
    result = nil
    if params[:shipment][:cancel] == "1"
      result = "キャンセル ： あり"
    elsif params[:shipment][:cancel] == "2"
      result = "キャンセル ： なし"
    end
    return result
  end

  def keyword_result
    result = nil
    if params[:shipment][:keyword].present?
      result = "a"
    end
    return result
  end

  def expected_shipping_date_result
    result = nil
    if params[:shipment][:expected_shipping_date] == "1" && (params[:shipment][:expected_shipping_start_date].present? || params[:shipment][:expected_shipping_end_date].present?)
      result = "売上計上日 ： #{params[:shipment][:expected_shipping_start_date]} ~ #{params[:shipment][:expected_shipping_end_date]} #{params[:shipment][:expected_shipping_date_unspecified]=  "true" ? "※未入力を含む" : "" }"
    elsif params[:shipment][:expected_shipping_date] == "2"
      result = "売上計上日 ： 未入力のみ"
    elsif params[:shipment][:expected_shipping_date] == "3"
      result = "売上計上日 ： 入力済みのみ"
    end
    return result
  end

  def shipping_origin_result
    result = nil
    if params[:shipment][:shipping_origin] == "1"
      result = "自社"
    end
    return result
  end

  def partially_reserved_result
    result = nil
    if params[:shipment][:partially_reserved] == "true" && params[:shipment][:allocated] == "true"
      result = "引当状況 : 一部引当済、引当済"
    elsif params[:shipment][:partially_reserved] == "true"
      result = "引当状況 ： 一部引当済"
    elsif params[:shipment][:allocated] == "true"
      result = "引当状況 ： 引当済"
    end
    return result
  end

  def total_picking_result
    result = nil
    if params[:shipment][:total_picking] == "1"
      result = "個別ピッキング ： 未処理"
    elsif params[:shipment][:total_picking] == "2"
      result = "個別ピッキング ： 済み"
    end
    return result
  end

  def prefectures_result
    result = nil
    if params[:shipment][:prefectures].present?
      result = "都道府県 ： a"
    end
    return result
  end
end
