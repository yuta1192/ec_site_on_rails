class AddColumnToSetMonthlyHoliday < ActiveRecord::Migration[5.2]
  def change
    remove_column :set_monthly_holidays, :year_month
    add_column :set_monthly_holidays, :year, :integer
    add_column :set_monthly_holidays, :month, :integer
  end
end
