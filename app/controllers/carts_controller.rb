class CartsController < ApplicationController
  def index
  end

  def edit
    @cart_items = @current_user.cart.cart_items
  end

  def destroy
  end
end
