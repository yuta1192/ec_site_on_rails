class CreateShopHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_holidays do |t|
      t.boolean :calendar_display_flg, default: true, null: false
      t.boolean :sunday_break, default: true, null: false
      t.boolean :monday_break, default: false, null: false
      t.boolean :tuesday_break, default: false, null: false
      t.boolean :wednesday_break, default: false, null: false
      t.boolean :thursday_break, default: false, null: false
      t.boolean :friday_break, default: false, null: false
      t.boolean :saturday_break, default: true, null: false
      t.boolean :holiday_setting, default: true, null: false
      t.text :comment
      t.integer :set_monthly_holiday_id
      t.timestamps
    end
  end
end
