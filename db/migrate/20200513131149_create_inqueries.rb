class CreateInqueries < ActiveRecord::Migration[5.2]
  def change
    create_table :inqueries do |t|
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
