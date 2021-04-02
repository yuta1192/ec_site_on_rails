class Image < ApplicationRecord
  # is_banner_flg 真偽値 trueなら表示させる
  belongs_to :banner

  validates :image, presence: true
  validates :is_banner_flg, presence: true, inclusion: { in: [true, false] }
end
