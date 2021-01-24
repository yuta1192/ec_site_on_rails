class OrderHistoriesController < ApplicationController
  def index
    @categories = Category.select(:id, :name)
  end

  def search
    # 初期表示の際、ページ場所と表示数と表示方法のパラメータがないときは初期値を設定する。
    if params[:page].blank?
      params[:page] = 1
    end
    if params[:per].blank?
      params[:per] = 25
    end
    @page = params[:page]
    @per = params[:per]

    # order_history_productからカテゴリーや商品名などを取得するためincludeする
    query = OrderHistory.eager_load(:order_history_products)

    # パラメータを結合する
    start_time = DateTime.parse("#{search_params[:"start_date(1i)"]}-#{search_params[:"start_date(2i)"]}-#{search_params[:"start_date(3i)"]}")
    end_time = DateTime.parse("#{search_params[:"end_date(1i)"]}-#{search_params[:"end_date(2i)"]}-#{search_params[:"end_date(3i)"]}")
    @categories = [search_params[:category_1],search_params[:category_2],search_params[:category_3]]
    @categories.uniq!
    unless @categories.first.present?
      @categories = nil
    end

    # 検索クエリ
    @order_query = query.order_date_start_search(start_time).order_date_end_search(end_time).order_number_search(search_params[:order_number]).product_number_search(search_params[:product_number]).product_name_search(search_params[:product_name]).cancel_search(search_params[:cancel_flg])
    @order_query = @order_query.where(memo: search_params[:memo]) if search_params[:memo].present?
    @order_query = @order_query.where('products.category_id LIKE ?', @categories) if @categories.present?
    @order_query = @order_query.page(@page).per(@per)
  end

  def show
    @order_history = OrderHistory.find(params[:id])
    # 合計金額
    @price = 0
    @order_history.order_history_products.each do |p|
      @price += (p.product.price * p.num)
    end
  end

  def cart_add
    # 作成したらtrueフラグに変更して条件分岐
    add_flg = false
    user_cart = @current_user.cart
    products = Product.where(id: params[:cart_item][:product_id])
    # チェックした商品の数だけカート内にアイテムを追加する。既にある場合は作成しない
    ActiveRecord::Base.transaction do
      products.each do |p|
        unless CartItem.find_by(product_id: p.id, cart_id: user_cart.id, cart_number: user_cart.cart_number).present?
          CartItem.create!(quantity: 1, product_id: p.id, cart_id: user_cart.id, cart_number: user_cart.cart_number, order_history_id: 1)
          add_flg = true
        end
      end
    end
    # 保存したらカートに移動
    if add_flg == true
      redirect_to edit_user_cart_path(@current_user.id, user_cart.id)
    else
      # todo エラー文追加(一つも追加してない場合)
      render 'show'
    end
    rescue => e
      # todo エラー文追加(作成時エラー)
      render 'show'
  end

  def one_cart_add
    add_flg = false
    user_cart = @current_user.cart
    ActiveRecord::Base.transaction do
      unless CartItem.find_by(product_id: params[:product_id], cart_id: user_cart.id, cart_number: user_cart.cart_number).present?
        CartItem.create!(quantity: 1, product_id: params[:product_id], cart_id: user_cart.id, cart_number: user_cart.cart_number, order_history_id: 1)
        add_flg = true
      end
    end

    # 保存したらカートに移動
    if add_flg == true
      redirect_to edit_user_cart_path(@current_user.id, user_cart.id)
    else
      # todo エラー文追加(一つも追加してない場合)
      render 'show'
    end
    rescue => e
      # todo エラー文追加(作成時エラー)
      render 'show'
  end

  private

    def search_params
      params.require(:order_history).permit(:start_date, :end_date, :order_number, :product_name, :product_number, :category_1, :category_2, :category_3, :memo, :cancel_flg)
    end
end
