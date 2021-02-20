class CartsController < ApplicationController
  def index
  end

  def edit
    @cart_items = CartItem.where(cart_number: @current_user.cart.cart_number)
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
      @current_user.addresses.each do |address|
        addresses_name << [address.company_name, address.id]
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
        redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
      else
        render 'edit'
      end
    end
  end

  def confirm
    @cart_items = CartItem.where(cart_number: @current_user.cart.cart_number)
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
    @address_attribute = params[:companies].to_i == 0 ? params[:address] : Address.find(params[:companies])
    @date_array = date_select_box.select {|k,v| v == params[:date].to_i} if params[:date] != "99"
    @date = @date_array.flatten.first if @date_array != nil

    # 宛先新規作成+チェックが付いてた場合アドレス作成
    if params[:companies].to_i == 0 && params[:address][:address_create] == "true" && params[:use_basic_email_flg].to_i == 2
      ActiveRecord::Base.transaction do
        # telとphone_numberは間に"-"を入れてパラメータに入れる
        tel = params[:address][:tel_1] + "-" + params[:address][:tel_2] + "-" + params[:address][:tel_3]
        phone_number = params[:address][:phone_number_1] + "-" + params[:address][:phone_number_2] + "-" + params[:address][:phone_number_3]
        zip_code = params[:address][:zip_code_1] + "-" + params[:address][:zip_code_2]

        address = Address.new(company_name: params[:address][:company_name], department_name: params[:address][:department_name], name_sei: params[:address][:name_sei], name_mei: params[:address][:name_mei], name_sei_kana: params[:address][:name_sei_kana], name_mei_kana: params[:address][:name_mei_kana], zip_code: zip_code, prefectures: params[:address][:prefectures], municipation: params[:address][:municipation], address_1: params[:address][:address_1], address_2: params[:address][:address_2], tel: tel, phone_number: phone_number, user_id: @current_user.id, is_select_flag: false, company_code: SecureRandom.alphanumeric(6), department_code: SecureRandom.alphanumeric(6), fax: nil, delivery_id: nil)
        address.save!
      end
    end
  end

  def complite
    order_history = OrderHistory.find(params[:order_history_id])
    @order_number = order_history.order_number
  end

  def create
    @cart_info = @current_user.cart
    # ここ作るとき全部正常に作られる必要があるからトランザクションでいく
    ActiveRecord::Base.transaction do
      # order_numberはランダムで作成(同じのがあった場合loopして新しく作る)
      order_history_number = SecureRandom.alphanumeric()
      loop do
        if OrderHistory.find_by(order_number: order_history_number) == nil
          break
        end
        order_history_number = SecureRandom.alphanumeric()
      end

      # todo shipment系はどうするのか
      # memo: 備考, status: 1(出荷前), payment: 1(入金待ち), allocation_status: 1(未引当), shipping_status: 1(未処理), postage_confirmation: 1(確認済み)
      @order_history = OrderHistory.new(order_number: order_history_number, memo: params[:remakes], status: 1, user_id: @current_user.id, cart_number: @cart_info.cart_number, cart_id: @cart_info.id, order_date_start: DateTime.now, preferred_date_flg: params[:preferred_date_flg], preferred_date_start: @date, invoice_number: SecureRandom.alphanumeric(), payment_method: params[:payment_method], payment: 1, allocation_status: 1, shipping_status: 1, postage_confirmation: 1, cancel_flg: 0)
      @order_history.save!

      # purchase_history作成と在庫の減少
      params[:cart_item].each do |cart_item|
        product = Product.find(cart_item["product_id"])
        stock = (product.stock_management.stock - cart_item["quantity"].to_i)
        product.stock_management.update!(stock: stock)
        @purchase_history = PurchaseHistory.new(cart_number: @cart_info.cart_number, order_history_id: @order_history.id, product_id: cart_item["product_id"], stock: cart_item["quantity"])
        @purchase_history.save!
      end

      # パラメータからDeliveryInfoの作成
      if params[:current_address_flg].to_i == 0
        delivery_info = DeliveryInfo.new(company_name: params[:addresses][:company_name], user_name: params[:addresses][:user_name], zip_code: params[:addresses][:zip_code], address: params[:addresses][:address] ,tel: params[:addresses][:tel], phone_number: params[:addresses][:phone_number], delivery_day: params[:date], purchase_history_id: @purchase_history.id, order_history_id: @order_history.id)
      else
        # パラメータをまとめる
        user_name = @current_user.name_sei + @current_user.name_mei
        address = @current_user.prefectures + @current_user.municipation + @current_user.address_1 + @current_user.address_2
        delivery_info = DeliveryInfo.new(company_name: @current_user.company_name, user_name: user_name, zip_code: @current_user.zip_code, address: address ,tel: @current_user.tel, phone_number: @current_user.phone_number, delivery_day: params[:date], purchase_history_id: @purchase_history.id, order_history_id: @order_history.id)
      end
      delivery_info.save!

      # OrderHistoryからCartItem引き出せるようにorder_history_idを作成
      @cart_items = CartItem.where(cart_number: @cart_info.cart_number)
      @cart_items.each do |cart_item|
        cart_item.update(order_history_id: @order_history.id)
      end

      # カートの処理
      cart_number = SecureRandom.alphanumeric(10)
      loop do
        if Cart.find_by(cart_number: cart_number) == nil
          break
        end
        cart_number = SecureRandom.alphanumeric(10)
      end
      @cart_info.update!(cart_number: cart_number)
    end
    # 成功時の処理
    redirect_to user_cart_complite_path(@current_user, @cart_info, order_history_id: @order_history.id)
    rescue => e
      render 'confirm'
      #todo バリデーションエラーの時返すものを書く
  end

  def destroy
    cart_item = CartItem.find(params[:cart_item_id])
    if cart_item.destroy!
      redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
    else
      render edit_user_cart_path(@current_user, @current_user.cart.id)
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
