class AddReleaseFlagToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_release_flg, :boolean, default: false, null: false
  end
end
