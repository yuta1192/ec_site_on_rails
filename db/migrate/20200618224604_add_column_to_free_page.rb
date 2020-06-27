class AddColumnToFreePage < ActiveRecord::Migration[5.2]
  def change
    add_column :free_pages, :h1_tag, :string
    add_column :free_pages, :url, :string
    add_column :free_pages, :place, :integer
    add_column :free_pages, :is_release_flg, :boolean, default: false, null: false
    add_column :free_pages, :is_login_flg, :boolean, default: false, null: false
    add_column :free_pages, :display_order, :integer
  end
end
