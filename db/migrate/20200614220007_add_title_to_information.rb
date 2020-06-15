class AddTitleToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :Information, :title, :string
  end
end
