class RemoveColumnToInquery < ActiveRecord::Migration[5.2]
  def change
    remove_column :Inqueries, :question_id
    add_column :Questions, :inquery_id, :integer
  end
end
