class AddPublishedFromInformation < ActiveRecord::Migration[5.2]
  def change
    # remove
    remove_column :information, :published_start_yyyymmdd
    remove_column :information, :published_start_hhmm
    remove_column :information, :published_end_yyyymmdd
    remove_column :information, :published_end_hhmm
    # add
    add_column :information, :published_start, :datetime
    add_column :information, :published_end, :datetime
  end
end
