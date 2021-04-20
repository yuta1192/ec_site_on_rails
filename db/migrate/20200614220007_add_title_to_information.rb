class AddTitleToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :title, :string
  end
end
