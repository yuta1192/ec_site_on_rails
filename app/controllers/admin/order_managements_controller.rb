class Admin::OrderManagementsController < ApplicationController
  def index
    session[:product_ids] = session[:product_ids].present? ? session[:product_ids] : []
    if params[:product_id].present?
      session[:product_ids] << params[:product_id]
      session[:product_ids].uniq!
    end

    if params[:user].present?
      @user = User.find_by(params[:user])
    end
    if params[:address].present?
      @address = Address.find_by(params[:address])
    end
    @user = @user.present? ? @user : nil
    @address = @address.present? ? @address : nil
    @products = Product.where(id: session[:product_ids])
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

  def order_history
  end

  def create
    if params[:order_history][:user].present?
      @user = User.find_by(params[:order_history][:user])
    end
    if params[:order_history][:address].present?
      @address = Address.find_by(params[:order_history][:address])
    end
    @user = @user.present? ? @user : nil
    @address = @address.present? ? @address : nil

    # 商品追加の場合
    if params[:product_add]
      product = Product.find_by(product_number: params[:order_history][:product_number])
      if product.present?
        session[:product_ids] << product.id.to_s
      end
      redirect_to admin_order_managements_path(user: @user.id, address: @address.id)
    else
      # 注文登録
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
        memo: params[:order_history][:memo],
        status: 1,
        user_id: @user.id,
        order_date_start: params[:order_history][:delivery_day],
        preferred_date_flg: false,
        preferred_date_start: nil,
        invoice_number: invoice_number,
        payment_method: params[:order_history][:payment_method],
        payment: 1,
        allocation_status: 1,
        shipping_status: 1,
        postage_confirmation: 1,
        cancel_flg: 0,
        address_id: @address.present? ? @address.id : @user.addresses.find_by(is_select_flag: true).id
      )
      @order_history.save!

      # order_history_products作成と在庫の減少
      @products = Product.where(id: session[:product_ids])
      @products.each do |p|
        stock = (p.stock_management.stock - params[:order_history][:product][p.id.to_s].to_i)
        if stock < 0
          raise StandardError
        end
        p.stock_management.update!(stock: stock)
        @order_history_products = OrderHistoryProduct.new(
          order_history_id: @order_history.id,
          product_id: p.id,
          num: params[:order_history][:product][p.id.to_s].to_i
        )
        @order_history_products.save!
      end

      # 初期設定(has_one: order_history追加、order_history_id追加)
      @shipment = Shipment.new(
        shipping_status: 1,
        allocation_status: 1,
        # order_history_id: @order_history.id
      )
      @shipment.save!

      @products.each do |p|
        @shipment_products = ShipmentProduct.new(
          shipment_id: @shipment.id,
          product_id: p.id,
          num: params[:order_history][:product][p.id.to_s].to_i,
          status: 1
        )
        @shipment_products.save!
      end
      #
      @order_history.update(shipment_id: @shipment.id)

      session[:product_ids] = nil
      redirect_to admin_order_managements_path
    end
  rescue => e
    @error = "システムエラーが発生しました。管理者に問い合わせください。"
    render :index and return
  end

  def order_history_search
    params[:page] = params[:page].blank? ? 1 : params[:page]
    params[:per] = params[:per].blank? ? 25 : params[:per]
    @page = params[:page]
    @per = params[:per]

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
        .search(order_history_params).page(@page).per(@per)

        # todo 出荷系も内部結合joinsしてselectしてviewに表示すること。
        # todo 住所は変わっている場合もあるため、OrderHistory自体にaddress_idを追加してjoin等をしたほうがいい（例えば同じユーザーでも複数住所登録可能プラスオーダーによって住所変えてるかもだから)
        # joins(user: :addresses, order_history_products: :product)
  end

  def user_search
    @users = User.all
    if params[:user].present?
      @users = @users.zip_code_search(params[:user][:zip_code_first], params[:user][:zip_code_second]).name_sei_search(params[:user][:name_sei]).name_mei_search(params[:user][:name_mei]).address_search(params[:user][:address]).e_mail_search(params[:user][:e_mail]).tel_search(params[:user][:tel_first], params[:user][:tel_second], params[:user][:tel_third]).company_name_search(params[:user][:company_name]).department_name_search(params[:user][:department_name])
    end
  end

  def address_search
    @user = @user.present? ? @user : nil
    if params[:user].present?
      @user = User.find_by(params[:user])
    end
    @user_address = @user.addresses
  end

  def product_search
    @user = @user.present? ? @user : nil
    if params[:user].present?
      @user = User.find_by(params[:user])
    elsif params[:product][:user]
      @user = User.find_by(params[:product][:user])
    end
    @address = @address.present? ? @address : nil
    if params[:address].present?
      @address = Address.find_by(params[:address])
    elsif params[:product][:address]
      @address = Address.find_by(params[:product][:address])
    end

    @products = Product.all
    if params[:product].present?
      @products.search(products_search_params[:name]).category_name_search(products_search_params[:category_name]).product_number_search(products_search_params[:product_number]).jan_code_search(products_search_params[:jan_code]).manufacturer_search(products_search_params[:manufacturer]).where(new_flg: products_search_params[:new_flg]).where(popular_flg: products_search_params[:popular_flg]).except_no_stock(products_search_params[:stock])
    end
  end

  def select_product_delete
    if params[:user].present?
      @user = User.find_by(params[:user])
    end
    if params[:address].present?
      @address = Address.find_by(params[:address])
    end
    @user = @user.present? ? @user : nil
    @address = @address.present? ? @address : nil

    session[:product_ids].delete(params[:product_id])
    redirect_to admin_order_managements_path(user: @user.id, address: @address.id)
  end

  private

  def order_history_params
    params.require(:order_history).permit(:order_date_start, :order_date_end, :order_preferred_date_start, :order_preferred_date_end, :unspecified, :preferred_date, :order_number, :product_number, :product_name, :new_product, :popular_product, :manufacturer, :invoice_number, :company_name, :department_code, :department_name, :member_code, :contact_name, :tel, :mail_address, :payment_method, :payment, :unallocated, :partially_reserved, :allocated, :untreated, :can_be_shipped, :undertake, :shipped, :postage_confirmation, :shipping_origin, :cancel, :order_display)
  end

  def order_display
    order_history_params[:order_display]
  end

  def products_search_params
    params.require(:product).permit(:product_number, :name, :jan_code, :new_flg, :popular_flg, :category_name, :manufacturer, :stock)
  end
end
