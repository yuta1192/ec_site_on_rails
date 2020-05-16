class TopPagesController < ApplicationController
  def index
    @categories = Product.select(:category).distinct
  end
end
