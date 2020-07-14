class Admin::ShopsController < ApplicationController
  def index
    @shop = Shop.find(1)
  end
end
