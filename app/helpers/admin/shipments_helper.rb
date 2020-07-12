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
end
