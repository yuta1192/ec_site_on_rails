class FreePage < ApplicationRecord
  # 自由ページ
  # FreePageはPageContetを複数所有している

  # page_title ページのタイトル
  # h1_tag h1タグ
  # url url
  # place 0:非表示、1:画面上部、2:画面下部、3:画面上部、下部
  # is_release_flg 自由ページを公開、非公開の設定（true:公開, false:非公開)
  # is_login_flg 自由ページをログインしていないと見れないようにする(true:見れない,false:見れる)
  # display_order 自由ページの表示順を変更する

  has_many :page_contents
  accepts_nested_attributes_for :page_contents

  validates :page_title, presence: true, length: { maximum: 20 }
  validates :url, presence: true
  validates :place, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }, presence: true
  validates :is_release_flg, presence: true
  validates :is_login_flg, presence: true
  validates :display_order, presence: true, numericality: { only_integer: true }
end
