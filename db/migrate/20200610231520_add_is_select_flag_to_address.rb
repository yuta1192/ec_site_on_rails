class AddIsSelectFlagToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :is_select_flag, :boolean, default: false, null: false
  end
end
