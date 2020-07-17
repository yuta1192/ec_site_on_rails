class Admin::ShopHolidaysController < ApplicationController
  def index
    @shop_holiday = ShopHoliday.find(1)
  end
end
