class RemoveColumnToInquery < ActiveRecord::Migration[5.2]
  def change
    remove_column :inqueries, :question_id
    add_column :questions, :inquery_id, :integer
  end
end
