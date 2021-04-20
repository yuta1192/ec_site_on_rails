class InformationChangeFileKata < ActiveRecord::Migration[5.2]
  def change
    remove_column :information, :attachment_file1
    add_column :information, :attachment_file1, :binary
    remove_column :information, :attachment_file2
    add_column :information, :attachment_file2, :binary
    remove_column :information, :attachment_file3
    add_column :information, :attachment_file3, :binary
    remove_column :information, :attachment_file4
    add_column :information, :attachment_file4, :binary
    remove_column :information, :attachment_file5
    add_column :information, :attachment_file5, :binary
  end
end
