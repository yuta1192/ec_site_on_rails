class Information < ApplicationRecord
  # published_start,published_endは、登録の際は、Time.zone.parse(published_start(end)_yyyymmdd.strftime("%Y/%m/%d") + hhmm) time型


  has_one :info_title
  has_many :information_attachment_files
  accepts_nested_attributes_for :information_attachment_files
end
