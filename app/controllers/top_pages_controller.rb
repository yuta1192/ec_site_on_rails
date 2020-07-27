class TopPagesController < ApplicationController
  def index
    @product_categories = Category.all
  end
end
