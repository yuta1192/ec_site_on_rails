class OrderHistoriesController < ApplicationController
  def index
    @categories = Product.select(:category).distinct
  end

  def search
    @params = params
  end

  private

    def search_params
      params.require(:order_history).permit(:start_date, :end_date, :order_number, :product_number, :product_name, :category, :memo)
    end
end
