class Admin::ShopsController < ApplicationController
  def index
    @shop = Shop.find(1)
    @open_or_close = @shop.open_flg == true ? "営業中" : "閉店"
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      start_condition = start_condition_set(picking_params)
      if @shop.update(start_condition: start_condition)
        redirect_to admin_shops_path
      end
    else
      render 'index'
    end
  end

  def open_or_close
    @shop = Shop.find(params[:id])
    if @shop.open_flg == true
      @shop.update(open_flg: false)
    else
      @shop.update(open_flg: true)
    end
    redirect_to admin_shops_path
  end

  private

    def shop_params
      params.require(:shop).permit(:name, :company_name, :zip_code, :prefectures, :municipation, :address_1, :address_2, :tel, :fax, :email, :stock_notification_num, :payment_method, :billing_customer_code, :product_name_setting, :name_set, :shipped_flg, :set_shipping_company_flg, :product_consumption_tax_flg, :tax_rate)
    end

    def picking_params
      params.require(:shop).permit(:total_picking, :invidible_picking, :shipping_yotei, :derively_company)
    end

    def start_condition_set(params)
      if params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 1
        shipping_status = 1
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 0
        shipping_status = 2
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 1
        shipping_status = 3
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 1
        shipping_status = 4
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 1
        shipping_status = 5
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 0
        shipping_status = 6
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 0
        shipping_status = 7
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 0
        shipping_status = 8
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 1
        shipping_status = 9
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 1
        shipping_status = 10
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 1
        shipping_status = 11
      elsif params[:total_picking].to_i == 1 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 0
        shipping_status = 12
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 1 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 0
        shipping_status = 13
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 1 && params[:derively_company].to_i == 0
        shipping_status = 14
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 1
        shipping_status = 15
      elsif params[:total_picking].to_i == 0 && params[:invidible_picking].to_i == 0 && params[:shipping_yotei].to_i == 0 && params[:derively_company].to_i == 0
        shipping_status = 16
      end
      return shipping_status
    end
end
