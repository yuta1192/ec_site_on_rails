class AddColumnToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :release_flg, :boolean, default: true, null: false
    add_column :information, :published_start, :date
    add_column :information, :published_end, :date
    add_column :information, :attachment_file1, :string
    add_column :information, :attachment_file2, :string
    add_column :information, :attachment_file3, :string
    add_column :information, :attachment_file4, :string
    add_column :information, :attachment_file5, :string
    remove_column :information, :image
  end
end
