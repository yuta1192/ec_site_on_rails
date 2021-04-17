class CreateInformationAttachmentFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :information_attachment_files do |t|
      t.integer :information_id
      t.string :attachment_file
      t.string :filename
      t.string :filepath
      t.timestamps
    end
  end
end
