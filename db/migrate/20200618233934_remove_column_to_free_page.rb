class RemoveColumnToFreePage < ActiveRecord::Migration[5.2]
  def change
    remove_column :free_pages, :second_title
    remove_column :free_pages, :sentence
  end
end
