module TopPagesHelper
  def select_categories
    all_category = []
    Category.all.each do |parent|
      all_category << parent.name
      if parent.child_categories.present?
        parent.child_categories.each do |child|
          all_category << "#{parent.name}/#{child.name}"
        end
      end
    end
    return all_category
  end
end
