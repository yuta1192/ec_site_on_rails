class TopPagesController < ApplicationController
  def index
    @product_categories = Category.all
    @new_products = Product.last(3).reverse
    @informations = Information.where(release_flg: true).release_period
    @logos = Banner.where(hyoji_area: 1)
    @under_banners = Banner.where(hyoji_area: 2)
  end
end
