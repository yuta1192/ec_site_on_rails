class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question
      t.text :answer
      t.integer :display_order_number
      t.timestamps
    end
  end
end
