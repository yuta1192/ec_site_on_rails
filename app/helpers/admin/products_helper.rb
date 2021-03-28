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
end
