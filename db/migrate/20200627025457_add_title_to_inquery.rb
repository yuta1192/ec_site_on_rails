class AddTitleToInquery < ActiveRecord::Migration[5.2]
  def change
    add_column :inqueries, :title, :string
  end
end
