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

  # 詳細からカートに商品作成
  def show_create
    @product = Product.find(params[:product_id])
    @category = Category.find(@product.category_id)

    cart_item = CartItem.find_by(product_id: @product.id, cart_id: @current_user.cart.id)
    # 既にカートにある場合はエラーメッセージ出して返す
    if cart_item.present?
      @error = "既にカートの中に商品があります。"
      render action: :show and return
    end

    # 数量入れてない場合はエラー
    if params[:quantity].blank?
      @error = "数量を記入してください。"
      render action: :show and return
    elsif params[:quantity].to_i < 1
      @error = "数量は1以上を記入してください。"
      render action: :show and return
    end

    cart_item = CartItem.new(product_id: params[:product_id], quantity: params[:quantity], cart_id: @current_user.cart.id)
    if cart_item.save!
      redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
    else
      @error = "システムエラーが発生しました。管理者に問い合わせてください。"
      render action: :show and return
    end
  end

  # 検索一覧からチェックした商品のカート、またはマイリストへの登録処理
  def create
    url = request.referer
    # 現在のurlにrenderするため取得
    @products = params[:check_product].keys
    check_product = []
    @products.each do |id|
      check_product << [product_id: params[:check_product][id][:product_id], quantity: params[:check_product][id][:quantity]] if params[:check_product][id][:check] == "true"
    end
    # チェックしているか
    unless check_product.present?
      @error = "チェックをしてください。"
      redirect_to url, flash: { error: @error }
      return
    end
    check_product.flatten!
    # 数量をセットしているか
    check_product.each do |product|
      unless product[:quantity].present?
        @error = "チェックした商品に数量を記入してください。"
        redirect_to url, flash: { error: @error }
        return
      end
    end
    # マイリストに追加の場合
    # マイリストが存在しない場合作成
    if params[:mylist].present?
      @mylist = MyList.find_by(user_id: @current_user.id)
      unless @mylist.present?
        @mylist = MyList.create(name: "newlist", user_id: current_user.id)
      end
      mylist_product = @mylist.user_my_list_products
      begin
        check_product.each do |product|
          # usermylistproductの中にチェックした商品が無ければマイリストに追加
          unless mylist_product.where(my_list_id: @mylist.id, product_id: product[:product_id]).present?
            product = UserMyListProduct.new(my_list_id: @mylist.id, product_id: product[:product_id], quantity: product[:quantity])
            product.save!
            # 保存が完了した時にマイリストが100件を越えたらエラー
            if mylist_product.count > 100
              raise RangeError, "マイリストが100件を越えました。削除してから再度実行してください。"
            end
          end
        end
        redirect_to user_my_list_path(user_id: @current_user.id, id: @mylist.id)
      rescue RangeError => e
        redirect_to url, flash: { error: e }
        return
      rescue => e
        @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
        redirect_to url, flash: { error: @error }
        return
      end
    else
      # カートに追加の場合
      begin
        check_product.each do |product|
          if CartItem.where(product_id: product[:product_id], cart_number: @current_user.cart.cart_number).present?
            cart_item = CartItem.find_by(product_id: product[:product_id], cart_number: @current_user.cart.cart_number)
            cart_item.update(quantity: product[:quantity])
          else
            cart_item = CartItem.new(quantity: product[:quantity], product_id: product[:product_id], cart_id: @current_user.cart.id, cart_number: @current_user.cart.cart_number)
            cart_item.save!
          end
        end
        redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
      rescue => e
        @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
        redirect_to url, flash: { error: @error }
        return
      end
    end
  end

  def quick_order
  end

  def quick_order_products
    @order_ids = params[:order].keys
    check_product = []
    @order_ids.each do |id|
      check_product << [product_number: params[:order][id][:product_number], quantity: params[:order][id][:quantity]]
    end
    check_product.flatten!
    # 両方ない場合は配列から削除
    check_product.delete_if{|product| product[:product_number].blank? && product[:quantity].blank?}

    @errors = []

    # check_productが存在するか
    unless check_product.present?
      @errors << "１つ以上の商品コードと数量を記載してください。"
      render 'quick_order' and return
    end

    # product_numberをセットしているか
    check_product.each do |product|
      if product[:product_number].blank? && product[:quantity].present?
        @errors << "数量を記載した場合、商品コードを記入してください。"
        break
      end
    end

    # 数量をセットしているか
    check_product.each do |product|
      if product[:product_number].present? && product[:quantity].blank?
        @errors << "商品コードを記載した場合、数量を記入してください。"
        break
      end
    end

    # 数量が数値以外
    check_product.each do |product|
      if product[:quantity].present?
        unless product[:quantity] =~ /^[0-9]+$/
          @errors << "数量は数値を記入してください。"
          break
        end
      end
    end

    # product_numberが存在しているか
    check_product.each do |product|
      unless product[:product_number].present? && Product.find_by(product_number: product[:product_number]).present?
        @errors << "対象の商品コードが存在しませんでした。"
        break
      end
    end

    # エラーがある場合は戻す
    if @errors.present?
      render 'quick_order' and return
    end

    check_product.each do |product|
      product_id = Product.find_by(product_number: product[:product_number]).id
      product[:product_number] = product_id
    end

    # カートに追加の場合 todo これだとあれじゃね、数量以上をカートに入れられちゃうわ
    begin
      check_product.each do |product|
        if CartItem.where(product_id: product[:product_number], cart_number: @current_user.cart.cart_number).present?
          cart_item = CartItem.find_by(product_id: product[:product_number], cart_number: @current_user.cart.cart_number)
          cart_item.update(quantity: product[:quantity])
        else
          cart_item = CartItem.new(quantity: product[:quantity], product_id: product[:product_number], cart_id: @current_user.cart.id, cart_number: @current_user.cart.cart_number)
          cart_item.save!
        end
      end
      redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
    rescue => e
      @errors << "システムエラーが発生しました。管理者に問い合わせしてください。"
      render 'quick_order' and return
    end
  end

  def update
    # todo update???
    binding.pry
    if Product.find(1).update!(image: params[:product][:image])
     redirect_to root_path
    else
    end
  end

  # 商品詳細からマイリスト追加処理
  def mylist_create
    @product = Product.find(params[:product_id])
    @category = Category.find(@product.category_id)

    # 数量入れてない場合はエラー
    if params[:num].blank?
      @error = "数量を記入してください。"
      render action: :show and return
    elsif params[:num].to_i < 1
      @error = "数量は1以上を記入してください。"
      render action: :show and return
    end

    # mylist_idが0なら新規作成、それ以外ならマイリストを名前から検索
    if params[:mylist_id].to_i == 0
      begin
        mylist = MyList.new(user_id: @current_user.id, name: "新しいマイリスト")
        mylist.save!

        mylist_product = UserMyListProduct.new(my_list_id: mylist.id, product_id: params[:product_id], quantity: params[:num])
        mylist_product.save!

        redirect_to user_my_list_path(@current_user.id, mylist)
      rescue => e
        @error = "システムエラーが発生しました。管理者に連絡してください。"
        render action: :show and return
      end
    else
      begin
        mylist = MyList.find_by(user_id: @current_user.id, id: params[:mylist_id])
        # マイリストがない場合はエラー
        raise StandardError if mylist.blank?
        # mylistに商品がないか確認、あれば何もせず、無かったら商品追加
        unless UserMyListProduct.find_by(my_list_id: mylist.id, product_id: params[:product_id]).present?
            mylist_product = UserMyListProduct.new(my_list_id: mylist.id, product_id: params[:product_id], quantity: params[:num])
            mylist_product.save!
        end
        redirect_to user_my_list_path(@current_user.id, mylist)
      rescue StandardError => e
        @error = "マイリストが存在しません。"
        render action: :show and return
      rescue => e
        @error = "システムエラーが発生しました。管理者に連絡してください。"
        render action: :show and return
      end
    end
  end


  private

    def select_categories
      a = []
      Category.all.each do |c|
        a << [c.name, c.id]
      end
      a.unshift['選択して下さい', nil]
    end

    def products_search_params
      params.require(:product).permit(:name, :category)
    end
end
