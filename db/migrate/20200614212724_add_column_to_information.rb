class AddColumnToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :Information, :release_flg, :boolean, default: true, null: false
    add_column :Information, :published_start, :date
    add_column :Information, :published_end, :date
    add_column :Information, :attachment_file1, :string
    add_column :Information, :attachment_file2, :string
    add_column :Information, :attachment_file3, :string
    add_column :Information, :attachment_file4, :string
    add_column :Information, :attachment_file5, :string
    remove_column :Information, :image
  end
end
