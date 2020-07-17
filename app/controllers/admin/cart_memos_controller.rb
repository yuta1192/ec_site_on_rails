class Admin::CartMemosController < ApplicationController
  def edit
    @cart_memo = CartMemo.find(1)
  end
end
