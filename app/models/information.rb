class Information < ApplicationRecord
  has_one :info_title
  has_many :information_attachment_files
  accepts_nested_attributes_for :information_attachment_files

  # 公開日の判定
  scope :release_period, -> { where('published_start <= ?', DateTime.current).where('? <= published_end', DateTime.current) }
end
