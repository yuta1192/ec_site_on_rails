class InformationAddAttachmentFileName < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :attachment_file1_name, :string
    add_column :information, :attachment_file2_name, :string
    add_column :information, :attachment_file3_name, :string
    add_column :information, :attachment_file4_name, :string
    add_column :information, :attachment_file5_name, :string
  end
end
