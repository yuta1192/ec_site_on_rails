module Admin::ProductsHelper
  def select_categories_name
    all_category = []
    Category.all.each do |parent|
      all_category << parent.name
      if parent.child_categories.present?
        parent.child_categories.each do |child|
          all_category << "#{child.name}"
        end
      end
    end
    all_category.unshift('選択して下さい')
    return all_category
  end

  # [name: カテゴリー名, ids: [親カテゴリーID, 子カテゴリー]]で返却する
  def select_categories
    all_category = []
    Category.all.each do |parent|
      all_category << [parent.name, [parent.id, nil]]
      if parent.child_categories.present?
        parent.child_categories.each do |child|
          all_category << [child.name, [parent.id, child.id]]
        end
      end
    end
    return all_category
  end

  def child_category
    category = Category.find(params[:category][:id])
    child_categories = category.child_categories
    child_categories_select = []
    child_categories.each do |cc|
      child_categories_select << [cc.name, cc.id]
    end
    child_categories_select.unshift(["新規作成または親のみ更新", 99])
    return child_categories_select
  end
end
