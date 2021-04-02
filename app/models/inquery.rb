class Inquery < ApplicationRecord
  # よくある質問（大質問）
  # questionテーブルに疑問(小質問)、答えをストック
  # 大 - 小:答え、小:答え のようになる。

  has_many :questions
  accepts_nested_attributes_for :questions
  validates :title, presence: true
end
