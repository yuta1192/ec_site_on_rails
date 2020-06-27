class RenameColumnToFreePage < ActiveRecord::Migration[5.2]
  def change
    rename_column :free_pages, :title, :page_title
  end
end
