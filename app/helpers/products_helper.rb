module ProductsHelper
  # 商品詳細のマイリストのセレクト作成
  def mylist_select
    mylist = []
    if MyList.where(user_id: @current_user.id).present?
      mylists = MyList.where(user_id: @current_user.id)
      mylists.each do |ml|
        mylist << [ml.name, ml.id]
      end
      # マイリストが5個まで作成可能なので、5未満なら新規作成できるように修正
      if mylists.count < 5
        mylist.unshift(['マイリストを新規作成する', 0])
      end
    else
      # マイリストが既に存在する場合は新規作成のみ
      mylist << ['マイリストを新規作成する', 0]
    end
    mylist
  end
end
