module Admin::StockManagementsHelper
  def select_shipping_origin
    select = ShippingOrigin.pluck(:shipping_origin_name, :id).map{|so, i| [so, i]}
    select.unshift(['指定なし',99])
  end

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
