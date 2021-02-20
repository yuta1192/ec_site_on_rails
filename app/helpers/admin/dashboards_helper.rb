module Admin::DashboardsHelper
  def today_week
    weeks = %w[(日) (月) (火) (水) (木) (金) (土) (日)]
    week = weeks[Date.today.wday]
    return week
  end

  def yesterday_week
    weeks = %w[(日) (月) (火) (水) (木) (金) (土) (日)]
    week = weeks[Date.yesterday.wday]
    return week
  end

  def today_year_and_month
    day = "#{Date.today.year}" + "/" + "#{Date.today.month}"
    return day
  end
end
