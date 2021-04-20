class Image < ApplicationRecord
  # is_banner_flg 真偽値 trueなら表示させる
  mount_uploader :image, ImageUploader
  
  validates :image, presence: true
  validates :is_banner_flg, inclusion: { in: [true, false] }
end
