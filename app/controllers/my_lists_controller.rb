class MyListsController < ApplicationController
  before_action :side_menu_mylists

  def index
  end

  def show
    @mylist_products = UserMyListProduct.joins(:product).where(mylist_id: params[:id])
  end

  # マイリストページ(index)のメニューからname入れて作成
  def create
    mylist = MyList.new(user_id: params[:my_list][:user_id], name: params[:my_list][:name])
    # マイリスト数チェック
    mylist_count = MyList.where(user_id: params[:my_list][:user_id]).count
    # 上限は10個、10個超えたら作らない
    if mylist_count < 10
      if mylist.save!
        redirect_to user_my_list_path(mylist.user_id, mylist.name)
      else
        # エラー処理
      end
    else
      # 10個超えてるからダメのエラーメッセージ返す
    end
  end

  def destroy
    delete_mylist = MyList.find(params[:id])
    if delete_mylist.destroy!
      redirect_to user_my_lists_path
    else
      # error時の処理
    end
  end

  def product_delete
    mylist = MyList.find_by(user_id: params[:user_id], id: params[:my_list_id])
    user_mylist_product = UserMyListProduct.find_by(mylist_id: mylist.id, product_id: params[:product_id])
    if user_mylist_product.destroy!
      redirect_to user_my_list_path(params[:user_id], params[:my_list_id])
    else
      # 削除失敗時処理
    end
  end

  def product_add_cart
    binding.pry
    # cartにproductを移す、でリダイレクトで自身のカートに飛ばす
  end

  def side_menu_mylists
    @mylists = MyList.where(user_id: current_user.id)
    @mylist_count = MyList.where(user_id: @current_user.id).present? ? MyList.where(user_id: @current_user.id).count : 0
  end
end
