class CartsController < ApplicationController
  def index
  end

  def edit
    @cart_items = CartItem.where(cart_number: User.find(6).cart.cart_number)
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
  end

  def show
    if params[:next]
      # お届け先のセレクトボックス作成
      addresses_name = [['新規お届け先',0]]
      @current_user.addresses.each.with_index(1) do |address, id|
        addresses_name << [address.company_name, id]
      end
      @addresses_name = addresses_name
      # お届け日のセレクトの部分作成
      @date_select = [['指定なし',99]]
      @current_date = Date.today.strftime("%Y/%m/%d/")
      (0..10).each do |i|
        @date_select << [(Date.today+(i+5)).strftime("%Y/%m/%d"), i]
      end
    else
      cart_item_id = params[:cart_item_id].keys.first
      update_quantity = params[:cart][:quantity][:product_quantity][cart_item_id].values.first.to_i
      @cart_item = CartItem.find(cart_item_id)
      if @cart_item.update(quantity: update_quantity)
        redirect_to edit_user_cart_path(@current_user, @current_user.cart_id)
      else
        render 'edit'
      end
    end
  end

  def confirm
    @cart_items = @current_user.cart.cart_items
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
    @address_attribute = params[:address] if params[:companies]
    @date_array = date_select_box.select {|k,v| v == params[:date].to_i} if params[:date] != "99"
    @date = @date_array.flatten.first if @date != nil
  end

  def complite
  end

  def create
    @cart_info = @current_user.cart
    # ここ作るとき全部正常に作られる必要があるからトランザクションでいく
    ActiveRecord::Base.transaction do
      # order_numberはランダムで作成
      order_history_number = SecureRandom.alphanumeric()
      # memo: 備考, status: 考えてないけど、購入した段階（enumで作る、最初は1かな)
      order_history = OrderHistory.new(order_number: order_history_number, memo: params[:remakes], status: 1, user_id: @current_user.id, cart_number: @cart_info.cart_number)
      order_history.save!
      # purchase_history作成
      purchase_history = PurchaseHistory.new(cart_id: @cart_info.id, cart_number: @cart_info.cart_number, order_history_id: order_history.id)
      purchase_history.save!
      # パラメータからDeliveryInfoの作成
      delivery_info = DeliveryInfo.new(company_name: params[:addresses][:company_name], user_name: params[:addresses][:user_name], zip_code: params[:addresses][:zip_code], address: params[:addresses][:address] ,tel: params[:addresses][:tel], phone_number: params[:addresses][:phone_number], delivery_day: params[:date], purchase_history_id: purchase_history.id, order_history_id: order_history.id)
      delivery_info.save!
      # OrderHistoryからCartItem引き出せるようにorder_history_idを作成
      @cart_items = CartItem.where(cart_number: @cart_info.cart_number)
      @cart_items.each do |cart_item|
        cart_item.update(order_history_id: order_history.id)
      end
      # カートの処理
      cart_number = SecureRandom.alphanumeric(10)
      @cart_info.update!(cart_number: cart_number)
      #todo バリデーションエラーの時返すものを書く
    end
    redirect_to user_cart_complite_path(@current_user, @cart_info)
  end

  def destroy
    cart_item = CartItem.find(params[:cart_item_id])
    if cart_item.destroy!
      redirect_to edit_user_cart_path(@current_user, @current_user.cart_id)
    else
      render edit_user_cart_path(@current_user, @current_user.cart_id)
    end
  end

    private

    def date_select_box
      @date_select = [['指定なし',99]]
      @current_date = Date.today.strftime("%Y/%m/%d/")
      (0..10).each do |i|
        @date_select << [(Date.today+(i+5)).strftime("%Y/%m/%d"), i]
      end
      return @date_select
    end
end
