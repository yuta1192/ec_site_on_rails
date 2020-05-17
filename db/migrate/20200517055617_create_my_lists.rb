class CreateMyLists < ActiveRecord::Migration[5.2]
  def change
    create_table :my_lists do |t|

      t.timestamps
    end
  end
end
