class Admin::StockManagementsController < ApplicationController
  def index
    @products = Product.all
  end

  def search
  end

  def bluk_edit
    if params[:previous_action] == "search"

    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
    @stock_management = StockManagement.find(params[:id])
    @stock_fluctuations = StockFluctuation.where(stock_management_id: @stock_management.id).limit(10)
  end
end
