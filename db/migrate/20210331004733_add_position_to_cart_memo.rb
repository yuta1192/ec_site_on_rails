class AddPositionToCartMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_memos, :position, :integer
  end
end
