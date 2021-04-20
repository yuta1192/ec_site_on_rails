class RemoveInformatinoAttachmentColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :information, :attachment_file1
    remove_column :information, :attachment_file2
    remove_column :information, :attachment_file3
    remove_column :information, :attachment_file4
    remove_column :information, :attachment_file5
    remove_column :information, :attachment_file1_name
    remove_column :information, :attachment_file2_name
    remove_column :information, :attachment_file3_name
    remove_column :information, :attachment_file4_name
    remove_column :information, :attachment_file5_name
  end
end
