class CreateSetMonthlyHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :set_monthly_holidays do |t|
      t.date :year_month
      t.string :set_holidays
      t.timestamps
    end
  end
end
