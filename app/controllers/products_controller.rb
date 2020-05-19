class ProductsController < ApplicationController
  def search
    @product_categories = Product.select(:category).distinct
    @search_params = products_search_params
    @products = Product.search(@search_params)
  end

  def quick_order
  end

  private

    def products_search_params
      params.require(:product).permit(:name, :category)
    end
end
