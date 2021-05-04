module Admin::ShopHolidaysHelper
  def select_day
    if params[:set_monthly_holiday].present?
      now = Date.new(Time.current.year, params[:set_monthly_holiday][:month].to_i)
    else
      now = Time.current
    end
    a = ((now.beginning_of_month.day)..(now.end_of_month.day)).to_a
    return a
  end
end
