class OrderHistoriesController < ApplicationController
  def index
    @categories = Category.select(:id, :name)
  end

  def search
    # 初期表示の際、ページ場所と表示数と表示方法のパラメータがないときは初期値を設定する。
    @order = params[:order] || "order_histories.created_at desc"
    @page = params[:page] || 1
    @per = params[:per] || 25

    query = OrderHistory.eager_load(:order_history_products).includes(:products).includes(:shipment)

    # パラメータを結合する
    start_time = DateTime.parse("#{search_params[:"start_date(1i)"]}-#{search_params[:"start_date(2i)"]}-#{search_params[:"start_date(3i)"]}")
    end_time = DateTime.parse("#{search_params[:"end_date(1i)"]}-#{search_params[:"end_date(2i)"]}-#{search_params[:"end_date(3i)"]}")
    @categories = "(#{search_params[:category_1]},#{search_params[:category_2]},#{search_params[:category_3]})"

    # 検索クエリ
    @order_query = query.order_date_start_search(start_time).order_date_end_search(end_time).order_number_search(search_params[:order_number]).product_number_search(search_params[:product_number]).product_name_search(search_params[:product_name]).cancel_search(search_params[:cancel_flg]).memo_search(search_params[:memo])

    # todo IN句のせいかSQLがめちゃくちゃ発行されている、どうにかするべき
    if @categories.present?
      @order_query.where("products.category_id IN #{@categories}")
    end
    @order_query_count = @order_query.count
    @order_query = @order_query.order(@order).page(@page).per(@per)

    session[:search_params] = params
  end

  def show
    @order_history = OrderHistory.find(params[:id])
    # 合計金額
    @price = 0
    @order_history.order_history_products.each do |p|
      @price += (p.product.price * p.num)
    end
    @zei = (@price*0.1).ceil
    @no_zei_price = (@price*0.9).ceil
  end

  def cart_add
    # 合計金額
    @price = 0
    @order_history.order_history_products.each do |p|
      @price += (p.product.price * p.num)
    end
    @zei = (@price*0.1).ceil
    @no_zei_price = (@price*0.9).ceil

    @order_history = OrderHistory.find(params[:order_history_id])
    # 作成したらtrueフラグに変更して条件分岐
    add_flg = false
    cart = @current_user.cart
    products = Product.where(id: params[:cart_item][:product_id])
    # チェックした商品の数だけカート内にアイテムを追加する。既にある場合は作成しない
    ActiveRecord::Base.transaction do
      products.each do |p|
        unless CartItem.find_by(product_id: p.id, cart_id: cart.id).present?
          CartItem.create!(quantity: 1, product_id: p.id, cart_id: cart.id)
          add_flg = true
        end
      end
    end
    # 保存したらカートに移動
    if add_flg == true
      redirect_to edit_user_cart_path(@current_user.id, cart.id)
    else
      @error = "選択した商品は既にカートの中に商品が存在しています。"
      render :show and return
    end
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    render :show and return
  end

  def one_cart_add
    # 合計金額
    @price = 0
    @order_history.order_history_products.each do |p|
      @price += (p.product.price * p.num)
    end
    @zei = (@price*0.1).ceil
    @no_zei_price = (@price*0.9).ceil

    @order_history = OrderHistory.find(params[:order_history_id])
    add_flg = false
    user_cart = @current_user.cart
    ActiveRecord::Base.transaction do
      unless CartItem.find_by(product_id: params[:product_id], cart_id: user_cart.id).present?
        CartItem.create!(quantity: 1, product_id: params[:product_id], cart_id: user_cart.id)
        add_flg = true
      end
    end

    # 保存したらカートに移動
    if add_flg == true
      redirect_to edit_user_cart_path(@current_user.id, user_cart.id)
    else
      @error = "選択した商品は既にカートの中に商品が存在しています。"
      render 'show'
    end
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    render 'show'
  end

  def update
    # 合計金額
    @price = 0
    @order_history.order_history_products.each do |p|
      @price += (p.product.price * p.num)
    end
    @zei = (@price*0.1).ceil
    @no_zei_price = (@price*0.9).ceil

    # memoの更新
    @order_history = OrderHistory.find(params[:id])
    if @order_history.update(params[:memo])
      redirect_to user_order_history_path(@current_user.id, @order_history.id)
    else
      @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
      render 'show'
    end
  end

  private

    def search_params
      params.require(:order_history).permit(:start_date, :end_date, :order_number, :product_name, :product_number, :category_1, :category_2, :category_3, :memo, :cancel_flg).merge(per: params[:per], page: params[:page], order: params[:order])
    end
end
