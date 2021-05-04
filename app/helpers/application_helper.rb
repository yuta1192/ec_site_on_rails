module ApplicationHelper
  # サイドバーのカテゴリー検索のカテゴリー作成
  def select_categories
    all_category = []
    Category.all.each do |parent|
      all_category << parent.name
    end
    all_category.unshift('選択して下さい')
    return all_category
  end

  # カテゴリー一覧作成
  def product_categories
    product_categories = Category.all
    return product_categories
  end

  # 左のバナー作成
  def banner_left
    Banner.where(hyoji_area: 1)
  end

  def shop_name
    Shop.first.name
  end

  def header_free_pages
    FreePage.where(place: [1,3])
  end

  def cart_product_count
    @current_user.cart.cart_items.count
  end

  def footer_free_pages
    FreePage.where(place: [2,3])
  end

  def ranking
    OrderHistoryProduct.range_current_month.group(:product_id).order('count(product_id) desc').limit(10)
  end
end
