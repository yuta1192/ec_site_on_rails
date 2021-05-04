class CartsController < ApplicationController
  def index
  end

  def edit
    @cart_items = @current_user.cart.cart_items
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
  end

  def show
    @now_address = @current_user.addresses.find_by(is_select_flag: true)
    unless params[:next]
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
    @now_address = @current_user.addresses.find_by(is_select_flag: true)

    # バリデーションチェック
    @errors = []
    if params[:use_basic_email_flg].blank? || (params[:use_basic_email_flg] != "1" && params[:use_basic_email_flg] != "2")
      @errors << "お届け先情報を選択してください。"
    end
    if params[:use_basic_email_flg] == "2" && params[:companies].blank?
      @errors << "お届け先を選択してください"
    end
    if params[:payment_method_flg].blank? || (params[:payment_method_flg] != "1" && params[:payment_method_flg] != "2")
      @errors << "お支払い方法を選択してください。"
    end
    if params[:date].blank?
      @errors << "お届け希望日を選択してください。"
    end
    if @errors.present?
      render :show and return
    end

    @use_basic_email_flg = params[:use_basic_email_flg]
    @company_select = params[:companies]

    if params[:use_basic_email_flg] == "1"
      @now_address
    else
      # 新規お届け先か
      if params[:companies] == "0"
        @new_address = {
          company_name: params[:company_name],
          department_name: params[:department_name],
          name_sei: params[:name_sei],
          name_mei: params[:name_mei],
          name_sei_kana: params[:name_sei_kana],
          name_mei_kana: params[:name_mei_kana],
          zip_code: params[:zip_code],
          prefectures: params[:prefectures],
          municipation: params[:municipation],
          address_1: params[:address_1],
          address_2: params[:address_2],
          tel: params[:tel],
          phone_number: params[:phone_number],
          address_create: params[:address_create]
        }
      else
        @address = @current_user.addresses.find_by(id: params[:companies]) # 既存のデータ
      end
    end
    # お支払い方法
    @payment_method = params[:payment_method_flg]
    # お届け希望日
    @date = params[:date]
    # 備考
    @memo = params[:remakes]

    # 表示
    @cart_items = @current_user.cart.cart_items
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @product_total_price = total_price
    @shouhi_zei = (@product_total_price * 0.1).ceil
    @total_price = @product_total_price + @shouhi_zei
    @address_attribute = params[:companies].to_i == 0 ? params[:address] : Address.find(params[:companies])
    @date_array = date_select_box.select {|k,v| v == params[:date].to_i} if params[:date] != "99"
    @date = @date_array.flatten.first if @date_array != nil
  end

  def create
    @address_attribute = params[:companies].to_i == 0 ? params[:addresses] : Address.find(params[:companies])

    ActiveRecord::Base.transaction do
      # 宛先新規作成+チェックが付いてた場合アドレス作成
      if params[:use_basic_email_flg].to_i == 2
        if params[:companies].to_i == 0 && params[:address][:address_create] == "true"
          @address = Address.new(
            company_name: params[:address][:company_name],
            department_name: params[:address][:department_name],
            name_sei: params[:address][:name_sei],
            name_mei: params[:address][:name_mei],
            name_sei_kana: params[:address][:name_sei_kana],
            name_mei_kana: params[:address][:name_mei_kana],
            zip_code: params[:address][:zip_code],
            prefectures: params[:address][:prefectures],
            municipation: params[:address][:municipation],
            address_1: params[:address][:address_1],
            address_2: params[:address][:address_2],
            tel: params[:address][:tel],
            phone_number: params[:address][:phone_number],
            user_id: @current_user.id,
            is_select_flag: false,
            company_code: SecureRandom.alphanumeric(6),
            department_code: SecureRandom.alphanumeric(6),
            fax: nil,
            delivery_id: nil
          )
          @address.save!
        else
          @address = @current_user.addresses.find_by(id: params[:companies])
        end
      else
        @address = @current_user.addresses.find_by(is_select_flag: true)
      end

      # order_history, order_history_products, shipment, shipment_productをここで作成

      # order_numberはランダムで作成(同じのがあった場合loopして新しく作る)
      order_history_number = SecureRandom.alphanumeric()
      loop do
        if OrderHistory.find_by(order_number: order_history_number).blank?
          break
        end
        order_history_number = SecureRandom.alphanumeric()
      end

      invoice_number = SecureRandom.alphanumeric()
      loop do
        if OrderHistory.find_by(invoice_number: invoice_number).blank?
          break
        end
        invoice_number = SecureRandom.alphanumeric()
      end

      # memo: 備考, status: 1(出荷前), payment: 1(入金待ち), allocation_status: 1(未引当), shipping_status: 1(未処理), postage_confirmation: 1(確認済み)
      @order_history = OrderHistory.new(
        order_number: order_history_number,
        memo: params[:remakes],
        status: 1,
        user_id: @current_user.id,
        order_date_start: DateTime.now,
        preferred_date_flg: params[:preferred_date_flg],
        preferred_date_start: @date,
        invoice_number: invoice_number,
        payment_method: params[:payment_method],
        payment: 1,
        allocation_status: 1,
        shipping_status: 1,
        postage_confirmation: 1,
        cancel_flg: 0,
        address_id: @address.id
      )
      @order_history.save!

      # order_history_products作成と在庫の減少
      params[:cart_item].each do |cart_item|
        product = Product.find(cart_item["product_id"])
        stock = (product.stock_management.stock - cart_item["quantity"].to_i)
        if stock < 0
          raise StandardError
        end
        product.stock_management.update!(stock: stock)
        @order_history_products = OrderHistoryProduct.new(
          order_history_id: @order_history.id,
          product_id: product.id,
          num: cart_item["quantity"]
        )
        @order_history_products.save!
      end

      # 初期設定(has_one: order_history追加、order_history_id追加)
      @shipment = Shipment.new(
        shipping_status: 1,
        allocation_status: 1,
        expected_shipping_date_flg: params[:preferred_date_flg],
        expected_shipping_date: @date
        # order_history_id: @order_history.id
      )
      @shipment.save!

      params[:cart_item].each do |cart_item|
        @shipment_products = ShipmentProduct.new(
          shipment_id: @shipment.id,
          product_id: cart_item["product_id"],
          num: cart_item["quantity"],
          status: 1
        )
        @shipment_products.save!
      end

      #
      @order_history.update(shipment_id: @shipment.id)

      # カートの商品全て削除
      @current_user.cart.cart_items.destroy_all
    end
    # 成功時の処理(todo ユーザーにメールを送信する)
    redirect_to user_cart_complite_path(@current_user, @current_user.cart.id, order_history_id: @order_history.id)
  rescue => e
    @cart_items = @current_user.cart.cart_items
    @error = "システムエラーが発生しました。管理者に問い合わせください。"
    render :confirm and return
  end

  def complite
    order_history = OrderHistory.find(params[:order_history_id])
    @order_number = order_history.order_number
    NotificationMailer.send_purchase_complite(current_user, order_history).deliver
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
