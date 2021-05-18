class Admin::DashboardsController < ApplicationController
  def index
    # 今月
    @order_histories_current_month = OrderHistory.range_current_month
    @month_order_products = OrderHistoryProduct.range_current_month.count
    @month_total_price = 0
    @order_histories_current_month.each do |ohcm|
      @month_total_price += ohcm.price
    end
    @month_add_user = User.range_current_month_user.count

    # 昨日
    @order_histories_yesterday = OrderHistory.range_yesterday
    @yesterday_order_products = OrderHistoryProduct.range_yesterday.count
    @yesterday_total_price = 0
    @order_histories_yesterday.each do |ohcm|
      @yesterday_total_price += ohcm.price
    end
    @yesterday_add_user = User.range_yesterday_user.count

    #今日
    @order_histories_today = OrderHistory.range_today
    @today_order_products = OrderHistoryProduct.range_today.count
    @today_total_price = 0
    @order_histories_today.each do |ohcm|
      @today_total_price += ohcm.price
    end
    @today_add_user = User.range_today_user.count

    @total_products = Product.all.count
    @release_total_products = Product.where(is_release_flg: true).count
    @out_of_stock = StockManagement.where(stock: 0).count

    @best_five = OrderHistoryProduct.range_current_month.group(:product_id).order('count(product_id) desc').limit(5)
    # todo 受注金額どうしよう。。。
  end

  def hazimeni
    @test = Test.new
  end

  def mongo
    Test.create!(mongo_params)
    redirect_to admin_hazimeni_path
  end

  private

  def mongo_params
    params.permit(:test).permit(:name, :test)
  end
end
