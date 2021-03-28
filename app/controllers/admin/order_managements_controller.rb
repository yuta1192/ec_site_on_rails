class Admin::OrderManagementsController < ApplicationController
  def index
  end

  def order_history
  end

  def order_history_search
    @order_histories =
      OrderHistory
        .joins("LEFT OUTER JOIN users ON order_histories.user_id = users.id")
        .joins("LEFT OUTER JOIN addresses ON order_histories.user_id = addresses.user_id")
        .eager_load(order_history_products: :product)
        .where(addresses: {is_select_flag: true})
        .select(
          "order_histories.id,
          order_histories.order_number,
          order_histories.preferred_date_flg,
          order_histories.preferred_date_start,
          order_histories.preferred_date_end,
          addresses.*"
        )
        .search(order_history_params)

        # todo 出荷系も内部結合joinsしてselectしてviewに表示すること。
        # todo 住所は変わっている場合もあるため、OrderHistory自体にaddress_idを追加してjoin等をしたほうがいい（例えば同じユーザーでも複数住所登録可能プラスオーダーによって住所変えてるかもだから)
        # joins(user: :addresses, order_history_products: :product)
  end

  private

  def order_history_params
    params.require(:order_history).permit(:order_date_start, :order_date_end, :order_preferred_date_start, :order_preferred_date_end, :unspecified, :preferred_date, :order_number, :product_number, :product_name, :new_product, :popular_product, :manufacturer, :invoice_number, :company_name, :department_code, :department_name, :member_code, :contact_name, :tel, :mail_address, :payment_method, :payment, :unallocated, :partially_reserved, :allocated, :untreated, :can_be_shipped, :undertake, :shipped, :postage_confirmation, :shipping_origin, :cancel, :order_display)
  end

  def order_display
    order_history_params[:order_display]
  end
end
