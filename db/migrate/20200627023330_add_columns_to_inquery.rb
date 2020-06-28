class AddColumnsToInquery < ActiveRecord::Migration[5.2]
  def change
    remove_column :Inqueries, :question
    remove_column :Inqueries, :answer
    add_column :Inqueries, :question_id, :integer
  end
end
