class Admin::ShopHolidaysController < ApplicationController
  def index
    @shop_holiday = ShopHoliday.find(1)
    if @shop_holiday.calendar_display_flg == true
      @display = "表示する"
    else
      @display = "表示しない"
    end

    @month = []
    12.times do |i|
      @month << ["#{i+1}月",i+1]
    end

    @set_month = params[:set_monthly_holiday].present? ? params[:set_monthly_holiday][:month] : Time.current.month
  end

  def update_calender_display
    @shop_holiday = ShopHoliday.find(1)
    if @shop_holiday.calendar_display_flg == true
      if @shop_holiday.update(calendar_display_flg: false)
        redirect_to admin_shop_holidays_path
      else
        render 'index'
      end
    else
      if @shop_holiday.update(calendar_display_flg: true)
        redirect_to admin_shop_holidays_path
      else
        render 'index'
      end
    end
  end

  def update
    @shop_holiday = ShopHoliday.find(1)
    if @shop_holiday.update(shop_holiday_params)
      redirect_to admin_shop_holidays_path
    else
      render 'index'
    end
  end

  def update_set_shop_holiday
    set_day = params[:set_monthly_holiday][:day].value == "1"
    days = set_day.keys
    @set_monthly_holiday = SetMonthlyHoliday.find_by(year: set_monthly_holiday_params[:year], month: set_monthly_holiday_params[:month])
    if @set_monthly_holiday.present?
      if @set_monthly_holiday.update(set_holidays: days)
        redirect_to admin_shop_holidays_path
      else
        render 'index'
      end
    else
      @set_monthly_holiday = SetMonthlyHoliday.new(year: params[:year], month: params[:month], set_holidays: days)
      if @set_monthly_holiday.save
        redirect_to admin_shop_holidays_path
      else
        render 'index'
      end
    end
  end

  private

    def set_monthly_holiday_params
      params.require(:set_monthly_holiday).permit(:month, :year)
    end

    def shop_holiday_params
      params.require(:shop_holiday).permit(:calendar_display_flg, :sunday_break, :monday_break, :tuesday_break, :wednesday_break, :thursday_break, :friday_break, :saturday_break, :holiday_setting, :comment)
    end
end
