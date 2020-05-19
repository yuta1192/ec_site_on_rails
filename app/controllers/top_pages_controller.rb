class TopPagesController < ApplicationController
  def index
    @product_categories = Product.select(:category).distinct
  end
end
