class Admin::HolidaySettingsController < ApplicationController
  def index
    @years = []
    5.times do |i|
      @years << ["#{Time.current.year+i}年", Time.current.year+i]
    end
  end

  def edit
    @years = []
    5.times do |i|
      @years << ["#{Time.current.year+i}年", Time.current.year+i]
    end
    @holiday_setting = HolidaySetting.find_by(year: holiday_setting_params[:year])
    unless @holiday_setting.present?
      @holiday_setting = HolidaySetting.new
    end
  end

  def bluk_update
    @holiday_setting = HolidaySetting.find_by(year: holiday_setting_params[:year])
    if @holiday_setting.present?
      # 更新
      if @holiday_setting.update(holiday_setting_params)
        redirect_to admin_holiday_settings_path
      else
        render 'edit'
      end
    else
      @holiday_setting = HolidaySetting.new(holiday_setting_params)
      # 新規作成
      if @holiday_setting.save
        redirect_to admin_holiday_settings_path
      else
        render 'edit'
      end
    end
  end

  private

    def holiday_setting_params
      params.require(:holiday_setting).permit(:year, :january_holiday, :february_holiday, :february_holiday, :march_holiday, :april_holiday, :may_holiday, :june_holiday, :july_holiday, :august_holiday, :september_holiday, :october_holiday, :november_holiday, :december_holiday)
    end
end
