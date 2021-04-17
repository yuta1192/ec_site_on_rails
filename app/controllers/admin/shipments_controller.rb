class Admin::ShipmentsController < ApplicationController
  def index
  end

  def show
    @shipment = Shipment.find(params[:id])
    @shipment_products = @shipment.shipment_products
    @order_history = @shipment.order_history
    @user = @order_history.user
    @addresses = @user.addresses
    @addresse = @addresses.find_by(is_select_flag: true)
  end

  def search
    # todo shipmentおよびorder_managementの検索方法についてはちゃんと考える。一旦保留。とりまseed作ってから
    @shipment_params = shipment_params
    @shipments = Shipment.includes(order_history: [user: :addresses, order_history_products: :product]).search(@shipment_params)
  end

  def update
    @ids = params[:shipment_product][:id]
    @shipment_products = ShipmentProduct.where(@ids)
    ActiveRecord::Base.transaction do
      @shipment_products.each do |sp|
        sp.update(shipment_product_update_params)
        sp.product.update(product_update_params)
      end
    end
    redirect_to admin_shipment_path(params[:id])
  end

  private

  def shipment_params
    params.require(:shipment).permit(:preferred_arrival_start_date, :preferred_arrival_end_date, :preferred_arrival_unspecified, :preferred_arrival_date, :order_start_date, :order_end_date, :keyword, :prefectures, :shipping_origin, :partially_reserved, :allocated, :untreated, :can_be_shipped, :undertake, :shipped, :expected_shipping_date, :expected_shipping_start_date, :expected_shipping_end_date, :expected_shipping_date_unspecified, :ship_start_date, :ship_end_date, :ship_date_unspecified, :sales_record_date, :sales_record_start_date, :sales_record_end_date, :sales_record_date_unspecified, :data_download, :total_picking, :individual_picking, :cancel, :order_display)
  end

  def product_update_params
    params.require(:shipment).permit(:shipping_company)
  end

  def shipment_product_update_params
    params.require(:shipment).permit(:status, :expected_shipping_date, :invoice_number, :ship_date, :shipping_email_flg)
  end
end
