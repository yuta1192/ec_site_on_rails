class AddColumnToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :informations, :release_flg, :boolean, default: true, null: false
    add_column :informations, :published_start, :date
    add_column :informations, :published_end, :date
    add_column :informations, :attachment_file1, :string
    add_column :informations, :attachment_file2, :string
    add_column :informations, :attachment_file3, :string
    add_column :informations, :attachment_file4, :string
    add_column :informations, :attachment_file5, :string
    remove_column :informations, :image
  end
end
