class Product < ApplicationRecord
  enum category: { オリジナル商品: 1, 食べ物: 2 }

  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
      .category_id(search_params[:category])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :category_id, -> (category) { where(category: category) if category.present? }
end
