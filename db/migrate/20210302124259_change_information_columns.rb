class ChangeInformationColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :informations, :date, :date
    remove_column :informations, :published_start
    add_column :informations, :published_start_yyyymmdd, :date
    add_column :informations, :published_start_hhmm, :string
    remove_column :informations, :published_end
    add_column :informations, :published_end_yyyymmdd, :date
    add_column :informations, :published_end_hhmm, :string
    remove_column :informations, :title
  end
end
