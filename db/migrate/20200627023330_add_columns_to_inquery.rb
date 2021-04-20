class AddColumnsToInquery < ActiveRecord::Migration[5.2]
  def change
    remove_column :inqueries, :question
    remove_column :inqueries, :answer
    add_column :inqueries, :question_id, :integer
  end
end
