class AddReleaseFlagToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :Products, :is_release_flg, :boolean, default: false, null: false
  end
end
