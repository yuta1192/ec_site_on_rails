class AddTitleToInquery < ActiveRecord::Migration[5.2]
  def change
    add_column :Inqueries, :title, :string
  end
end
