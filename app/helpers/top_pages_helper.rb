module TopPagesHelper
  def select_categories
    all_category = []
    Category.all.each do |parent|
      all_category << parent.name
    end
    all_category.unshift('選択して下さい')
    return all_category
  end

  def banner_left
    Banner.where(hyoji_area: 1)
  end

  def banner_under
    Banner.where(hyoji_area: 2)
  end
end
