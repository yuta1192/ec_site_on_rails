class ProductsController < ApplicationController
  def search
    @product_categories = Product.select(:category_id).distinct
    # 初期表示の際、ページ場所と表示数と表示方法のパラメータがないときは初期値を設定する。
    if params[:page].blank?
      params[:page] = 1
    end
    if params[:per].blank?
      params[:per] = 30
    end
    if params[:display].blank?
      params[:display] = "list_image"
    end
    if params[:order].blank?
      params[:order] = "created_at desc"
    end
    @page = params[:page]
    @per = params[:per]
    @display = params[:display]
    @order = params[:order]

    @products = Product.search(products_search_params[:name]).category_name_search(products_search_params[:category]).order(@order).page(@page).per(@per)
    @category_name = params[:product][:category]

    session[:name] = products_search_params[:name]
    session[:category] = products_search_params[:category]
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
    # 子カテゴリーがある場合はパンくず作る
    if @product.child_category_id.present?
      @child_category = @category.child_categories.find(@product.child_category_id)
    else
      @child_category = nil
    end
  end

  def show_create
    unless OrderHistory.where(cart_number: @current_user.cart.cart_number).present?
      order_history_number = SecureRandom.alphanumeric()
      order_history = OrderHistory.new(order_number: order_history_number, user_id: @current_user.id, cart_number: @current_user.cart.cart_number)
      order_history.save!
    end
    order_history_id = OrderHistory.find_by(cart_number: @current_user.cart.cart_number).id
    cart_item = CartItem.new(product_id: params[:product_id], quantity: params[:quantity], cart_id: @current_user.cart.id, cart_number: @current_user.cart.cart_number, order_history_id: order_history_id)
    if cart_item.save!
      redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
    else
      render product_path
    end
  end

  def create
    @products = params[:check_product].keys
    check_product = []
    @products.each do |id|
      check_product << [product_id: params[:check_product][id][:product_id], quantity: params[:check_product][id][:quantity]] if params[:check_product][id][:check] == "true"
    end
    if check_product
      if params[:mylist].present?
        check_product.flatten!
        check_product.each do |product|
          unless MyList.where(user_id: @current_user.id, product_id: product[:product_id])
            my_list = MyList.new(user_id: @current_user.id, product_id: product[:product_id])
            my_list.save!
          end
        end
        redirect_to user_my_lists_path(@current_user)
      else
        # order_numberはランダムで作成, cart_item
        unless OrderHistory.where(cart_number: @current_user.cart.cart_number).present?
          order_history_number = SecureRandom.alphanumeric()
          order_history = OrderHistory.new(order_number: order_history_number, user_id: @current_user.id, cart_number: @current_user.cart.cart_number)
          order_history.save!
        end
        check_product.flatten!
        ActiveRecord::Base.transaction do
          check_product.each do |product|
            if CartItem.where(product_id: product[:product_id], cart_number: @current_user.cart.cart_number).present?
              cart_item = CartItem.find_by(product_id: product[:product_id], cart_number: @current_user.cart.cart_number)
              cart_item.update(quantity: product[:quantity])
            else
              cart_item = CartItem.new(quantity: product[:quantity], product_id: product[:product_id], cart_id: @current_user.cart_id, cart_number: @current_user.cart.cart_number, order_history_id: order_history.id)
              cart_item.save!
            end
          end
        end
        redirect_to edit_user_cart_path(@current_user, @current_user.cart_id)
      end
    else
      render search
      flash[:error] = "error"
    end
  end

  def quick_order
    if params[:cart]
      unless OrderHistory.where(cart_number: @current_user.cart.cart_number).present?
        order_history_number = SecureRandom.alphanumeric()
        order_history = OrderHistory.new(order_number: order_history_number, user_id: @current_user.id, cart_number: @current_user.cart.cart_number)
        order_history.save!
      end
      order = params[:order].keys
      product_code = []
      order.each do |id|
        product_code << [product_code: params[:order][id][:product_code],quantity: params[:order][id][:quantity]] if (params[:order][id][:product_code] && params[:order][id][:quantity]).present?
      end
      render quick_order_products_path unless product_code.present?
      product_code.flatten!
      order_history_id = OrderHistory.where(cart_number: @current_user.cart.cart_number)
      product_code.each do |pc|
        if Product.where(product_number: pc[:product_code]).present?
          product = Product.where(product_number: pc[:product_code])
          unless CartItem.where(product_id: product.id, cart_number: @current_user.cart.cart_number)
            cart_item = CartItem.new(quantity: pc[:quantity], product_id: product.id, cart_id: @current_user.cart_id, cart_number: @current_user.cart.cart_number, order_history_id: order_history_id)
            cart_item.save!
          end
          redirect_to edit_user_cart_path(@current_user, @current_user.cart_id)
        else
          return redirect_to quick_order_products_path
        end
      end
    end
  end

  def update
    binding.pry
    if Product.find(1).update!(image: params[:product][:image])
     redirect_to root_path
    else
    end
  end

  private

    def select_categories
      a = []
      Category.all.each do |c|
        a << [c.name, c.id]
      end
      binding.pry
      a.unshift['選択して下さい', nil]
    end

    def products_search_params
      params.require(:product).permit(:name, :category)
    end
end
