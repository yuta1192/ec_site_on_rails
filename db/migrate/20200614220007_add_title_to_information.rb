class AddTitleToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :informations, :title, :string
  end
end
