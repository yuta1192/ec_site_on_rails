module Admin::ShopHolidaysHelper
  def select_day
    now = Time.current
    a = ((now.beginning_of_month.day)..(now.end_of_month.day)).to_a
    return a
  end
end
