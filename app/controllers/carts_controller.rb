class CartsController < ApplicationController
  def index
  end

  def edit
    @cart_items = @current_user.cart.cart_items
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
  end

  def show
    addresses_name = [['新規お届け先',0]]
    @current_user.addresses.each.with_index(1) do |address, id|
      addresses_name << [address.company_name, id]
    end
    @addresses_name = addresses_name
    # お届け日のセレクトの部分作成
    @date_select = [['指定なし',99]]
    @current_date = Date.today.strftime("%m%d")
    (0..10).each do |i|
      @date_select << [(Date.today+i).strftime("%m%d"), i]
    end
  end

  def purchase_confirm
    @cart_items = @current_user.cart.cart_items
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price * cart_item.quantity
    end
    @total_price = total_price
  end

  def destroy
  end
end
