class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.text :contact
      t.belongs_to :user

      t.timestamps
    end
  end
end
