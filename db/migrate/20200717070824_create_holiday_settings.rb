class CreateHolidaySettings < ActiveRecord::Migration[5.2]
  def change
    create_table :holiday_settings do |t|
      t.date :year
      t.string :january_holiday
      t.string :february_holiday
      t.string :march_holiday
      t.string :april_holiday
      t.string :may_holiday
      t.string :june_holiday
      t.string :july_holiday
      t.string :august_holiday
      t.string :september_holiday
      t.string :october_holiday
      t.string :november_holiday
      t.string :december_holiday
      t.timestamps
    end
  end
end
