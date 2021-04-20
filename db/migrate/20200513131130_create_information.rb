class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :informations do |t|
      t.text :detail
      t.string :image

      t.timestamps
    end
  end
end
