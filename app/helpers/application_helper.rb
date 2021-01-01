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
end
