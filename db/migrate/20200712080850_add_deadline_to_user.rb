class AddDeadlineToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deadline, :boolean, default: false, null: false
  end
end
