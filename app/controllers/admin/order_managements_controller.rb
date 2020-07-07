class Admin::OrderManagementsController < ApplicationController
  def index
  end

  def order_history
  end

  def order_history_search
    @search_params = order_history_params
    @order_histories = OrderHistory.search(@search_params)
    binding.pry
  end

  private

  def order_history_params
    params.require(:order_history).permit(:order_start_date, :order_end_date, :order_preferred_start_date, :order_preferred_end_date, :unspecified, :preferred_date, :order_number, :product_number, :product_name, :new_product, :popular_product, :manufacturer, :invoice_number, :company_name, :department_code, :department_name, :member_code, :contact_name, :tel, :mail_address, :payment_method, :payment, :unallocated, :partially_reserved, :allocated, :untreated, :can_be_shipped, :undertake, :shipped, :postage_confirmation, :shipping_origin, :cancel, :order_display)
  end

  def order_display
    order_history_params[:order_display]
  end
end
