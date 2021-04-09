class Shipment < ApplicationRecord
  has_one :order_history
  has_many :shipment_products

  scope :search, -> (shipment_params) do
    return if shipment_params.blank?

    preferred_arrival_date_search(shipment_params[:preferred_arrival_date], shipment_params[:preferred_arrival_unspecified])
      .preferred_arrival_start_date_search(shipment_params[:preferred_arrival_start_date], shipment_params[:preferred_arrival_date])
      .preferred_arrival_end_date_search(shipment_params[:preferred_arrival_end_date], shipment_params[:preferred_arrival_date])
      .order_start_date_search(shipment_params[:order_start_date])
      .order_end_date_search(shipment_params[:order_end_date])
      .prefectures_search(shipment_params[:prefectures])
      .shipping_origin_search(shipment_params[:shipping_origin])
      .allocation_status_search(shipment_params[:partially_reserved], shipment_params[:allocated])
      .shipping_status_search(shipment_params[:untreated],shipment_params[:can_be_shipped],shipment_params[:undertake],shipment_params[:shipped])
      .expected_shipping_date_search(shipment_params[:expected_shipping_date], shipment_params[:expected_shipping_date_unspecified])
      .expected_shipping_start_date_search(shipment_params[:expected_shipping_start_date])
      .expected_shipping_end_date_search(shipment_params[:expected_shipping_end_date])
      .ship_start_date_search(shipment_params[:ship_start_date])
      .ship_end_date_search(shipment_params[:ship_end_date])
      .sales_record_date_search(shipment_params[:sales_record_date], shipment_params[:sales_record_date_unspecified])
      .sales_record_start_date_search(shipment_params[:sales_record_start_date])
      .sales_record_end_date_search(shipment_params[:sales_record_end_date])
      .data_download_search(shipment_params[:data_download])
      .total_picking_search(shipment_params[:total_picking])
      .individual_picking_search(shipment_params[:individual_picking])
      .cancel_search(shipment_params[:cancel])
  end

  scope :preferred_arrival_date_search, -> arrival_date, preferred_arrival_unspecified {
    if arrival_date == "1" && preferred_arrival_unspecified == 'true'
      all
    elsif arrival_date == "1" && preferred_arrival_unspecified == 'false'
      where(arrival_date_flg: true)
    elsif arrival_date == "2"
      where(arrival_date_flg: false)
    elsif arrival_date == "3"
      where(arrival_date_flg: true)
    end
  }
  scope :preferred_arrival_start_date_search, -> arrival_date_start, preferred_arrival_date {
    where('? <= preferred_arrival_date', arrival_date_start) if arrival_date_start.present? && preferred_arrival_date == "1"
  }
  scope :preferred_arrival_end_date_search, -> arrival_date_end, preferred_arrival_date {
    where('preferred_arrival_date <= ?', arrival_date_end) if arrival_date_end.present? && preferred_arrival_date == "1"
  }
  scope :order_start_date_search, -> order_start_date { where('order_date <= ?', order_start_date) if order_start_date.present? }
  scope :order_end_date_search, -> order_end_date { where('? <= order_date', order_end_date) if order_end_date.present? }

  scope :keyword_search, -> keywords {}

  scope :prefectures_search, -> prefecture { where(prefectures: prefecture) if prefecture.present? }
  scope :shipping_origin_search, -> shipping_origin {
    if shipping_origin == "99"
      all
    else
      where(shipping_origin: shipping_origin)
    end
  }
  scope :allocation_status_search, -> partially_reserved, allocated {
    if partially_reserved == "true" && allocated == "true"
      all # 指定なし
    elsif partially_reserved == "true" && allocated == "false"
      where(allocation_status: 1)
    elsif partially_reserved == "false" && allocated == "true"
      where(allocation_status: 2)
    elsif partially_reserved == "false" && allocated == "false"
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
  scope :expected_shipping_date_search, -> expected_shipping_date, expected_shipping_date_unspecified {
    if expected_shipping_date == "1" && expected_shipping_date_unspecified == 'true'
      all
    elsif expected_shipping_date == "1" && expected_shipping_date_unspecified == 'false'
      where(expected_shipping_date_flg: true)
    elsif expected_shipping_date == "2"
      where(expected_shipping_date_flg: false)
    elsif expected_shipping_date == "3"
      where(expected_shipping_date_flg: true)
    end
  }
  scope :expected_shipping_start_date_search, -> expected_shipping_start_date {
    where('expected_shipping_date <= ?', expected_shipping_start_date) if expected_shipping_start_date.present? && shipment_params[:expected_shipping_date] == "1"
  }
  scope :expected_shipping_end_date_search, -> expected_shipping_end_date {
    where('? <= expected_shipping_date', expected_shipping_end_date) if expected_shipping_end_date.present? && shipment_params[:expected_shipping_date] == "1"
  }
  scope :ship_start_date_search, -> ship_start_date { where('ship_date <= ?', ship_start_date) if ship_start_date.present? }
  scope :ship_end_date_search, -> ship_end_date { where('? <= ship_date', ship_end_date) if ship_end_date.present? }
  scope :sales_record_date_search, -> sales_record_date, sales_record_date_unspecified {
    if sales_record_date == "1" && sales_record_date_unspecified == 'true'
      all
    elsif sales_record_date == "1" && sales_record_date_unspecified == 'false'
      where(sales_record_date_flg: true)
    elsif sales_record_date == "2"
      where(sales_record_date_flg: false)
    elsif sales_record_date == "3"
      where(sales_record_date_flg: true)
    end
  }
  scope :sales_record_start_date_search, -> sales_record_start_date {
    where('sales_record_date <= ?', sales_record_start_date) if sales_record_start_date.present? && shipment_params[:sales_record_date] == "1"
  }
  scope :sales_record_end_date_search, -> sales_record_end_date {
    where('? <= sales_record_date', sales_record_end_date) if sales_record_end_date.present? && shipment_params[:sales_record_date] == "1"
  }
  scope :data_download_search, -> data_download {
    if data_download == "99"
      all # 指定なし
    else
      where(data_download: data_download)
    end
  }
  scope :total_picking_search, -> total_picking {
    if total_picking == "99"
      all # 指定なし
    else
      where(total_picking: total_picking)
    end
  }
  scope :individual_picking_search, -> individual_picking {
    if individual_picking == "99"
      all # 指定なし
    else
      where(individual_picking: individual_picking)
    end
  }
  scope :cancel_search, -> cancel {
    if cancel == 'true'
      where(cancel: true)
    elsif cancel == 'false'
      where(cancel: false)
    end
  }
end
