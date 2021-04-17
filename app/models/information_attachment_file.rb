class InformationAttachmentFile < ApplicationRecord
  mount_uploader :attachment_file, ImageUploader

  belongs_to :information
end
