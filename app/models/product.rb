class Product < ApplicationRecord
  belongs_to :category
  belongs_to :stock_management
  belongs_to :shipping_origin
  belongs_to :child_category
  #enum category: { オリジナル商品: 1, 食べ物: 2 }

  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?', "%#{search}%"])
  end

  scope :category_name_search, -> category_name {
    return Product.all unless category_name
    return Product.all if category_name.blank?
    return Product.all if category_name == "選択して下さい"
    # 子カテゴリと親カテゴリで検索条件分け
    if category_name.include? "/"
      category_id = ChildCategory.find_by(name: "#{category_name.partition('/').last}").category_id
      child_category_id = ChildCategory.find_by(name: "#{category_name.partition('/').last}").id
      Product.where(category_id: category_id).where(child_category_id: child_category_id)
    else
      category_id = Category.find_by(name: "#{category_name}").id
      Product.where(category_id: category_id)
    end
  }

  scope :product_number_search, -> product_number {
    return Product.all unless product_number
    return Product.all if product_number.blank?
    Product.where(['product_number LIKE ?', "%#{product_number}%"])
  }

  scope :jan_code_search, -> jan_code {
    return Product.all unless jan_code
    return Product.all if jan_code.blank?
    Product.where(['jan_code LIKE ?', "%#{jan_code}%"])
  }

  scope :manufacturer_search, -> manufacturer {
    return Product.all unless manufacturer
    return Product.all if manufacturer.blank?
    Product.where(['manufacturer LIKE ?', "%#{manufacturer}%"])
  }

  scope :except_no_stock, -> stock {
    return Product.all if stock == "false"
    Product.where("stock = 0")
  }
  # scope :search, -> (search_params) do
  #   return if search_params.blank?
  #   name_like(search_params[:name])
  #     .category_id(search_params[:category])
  # end

  # scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  # scope :category_id, -> (category) { where(category: category) if category.present? }
end
