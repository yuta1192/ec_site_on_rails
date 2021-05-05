class MyListsController < ApplicationController
  before_action :side_menu_mylists

  def index
  end

  def show
    if params[:page].blank?
      params[:page] = 1
    end
    @page = params[:page]

    @mylist = MyList.find_by(id: params[:id], user_id: @current_user.id)
    @mylist_products = @mylist.user_my_list_products.order("created_at desc").page(@page).per(20)
  end

  # マイリストページ(index)のメニューからname入れて作成
  def create
    mylist = MyList.new(user_id: params[:my_list][:user_id], name: params[:my_list][:name])
    # マイリスト数チェック
    mylist_count = MyList.where(user_id: params[:my_list][:user_id]).count
    # 上限は10個、10個超えたら作らない
    if mylist_count >= 10
      @error = "マイリスト数が10個を越えました。削除してから再度実行してください。"
      render :index and return
    end

    if mylist.save!
      redirect_to user_my_list_path(mylist.user_id, mylist.id)
    else
      @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
      render :index and return
    end
  end

  def update
    mylist = MyList.find_by(id: params[:id], user_id: @current_user.id)
    mylist.update!(name: mylist_params[:name])
    redirect_to user_my_list_path(@current_user.id, mylist.id)
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    render :index and return
  end

  def destroy
    delete_mylist = MyList.find(params[:id])
    delete_mylist.destroy!
    redirect_to user_my_lists_path
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    render :index and return
  end

  def product_delete
    mylist = MyList.find_by(user_id: params[:user_id], id: params[:my_list_id])
    user_mylist_product = UserMyListProduct.find_by(my_list_id: mylist.id, product_id: params[:product_id])
    user_mylist_product.destroy!
    redirect_to user_my_list_path(params[:user_id], params[:my_list_id])
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    redirect_to user_my_list_path(@current_user.id, params[:my_list_id]), flash: { error: @error }
  end

  # マイリストからカートに商品を移す機能
  def product_add_cart
    # cartにproductを移す、でリダイレクトで自身のカートに飛ばす
    @products = params[:my_list][:check_product].keys
    check_product = []
    @products.each do |id|
      check_product << [product_id: params[:my_list][:check_product][id][:product_id], quantity: params[:my_list][:check_product][id][:quantity]] if params[:my_list][:check_product][id][:check] == "true"
    end

    # チェックしているか
    unless check_product.present?
      @error = "チェックをしてください。"
      redirect_to user_my_list_path(@current_user.id, params[:my_list][:my_list_id]), flash: { error: @error }
    end
    check_product.flatten!

    check_product.each do |product|
      # 数量をセットしているか
      unless product[:quantity].present?
        @error = "チェックした商品に数量を記入してください。"
        redirect_to user_my_list_path(@current_user.id, params[:my_list][:my_list_id]), flash: { error: @error }
      end
      # 数値バリデーション
      unless number?(product[:quantity])
        @error = "数値を入力してください。"
        redirect_to user_my_list_path(@current_user.id, params[:my_list][:my_list_id]), flash: { error: @error }
      end
    end

    check_product.each do |product|
      next if CartItem.where(product_id: product[:product_id], cart_number: @current_user.cart.cart_number).present?
      cart_item = CartItem.new(quantity: product[:quantity], product_id: product[:product_id], cart_id: @current_user.cart.id, cart_number: @current_user.cart.cart_number)
      cart_item.save!
    end
    # 成功redirect
    redirect_to edit_user_cart_path(@current_user, @current_user.cart.id)
  rescue
    # 失敗
    @error = "システムエラーが発生しました。管理者に問い合わせしてください。"
    redirect_to user_my_list_path(@current_user.id, params[:my_list][:my_list_id]), flash: { error: @error }
  end

  def side_menu_mylists
    @mylists = MyList.where(user_id: current_user.id)
    @mylist_count = MyList.where(user_id: @current_user.id).present? ? MyList.where(user_id: @current_user.id).count : 0
  end

  private

  def mylist_params
    params.require(:my_list).permit(:name)
  end

  def number?(str)
    # 文字列の先頭(\A)から末尾(\z)までが「0」から「9」の文字か
    nil != (str =~ /\A[0-9]+\z/)
  end

end
