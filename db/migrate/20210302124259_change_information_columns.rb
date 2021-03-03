class ChangeInformationColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :date, :date
    remove_column :information, :published_start
    add_column :information, :published_start_yyyymmdd, :date
    add_column :information, :published_start_hhmm, :string
    remove_column :information, :published_end
    add_column :information, :published_end_yyyymmdd, :date
    add_column :information, :published_end_hhmm, :string
    remove_column :information, :title
  end
end
