class TopPagesController < ApplicationController
  def index
    @product_categories = Category.all
    @new_products = Product.last(3).reverse
  end
end
