class Inquery < ApplicationRecord
  # よくある質問（大質問）
  # questionテーブルに疑問(小質問)、答えをストック
  # 大 - 小:答え、小:答え のようになる。

  has_many :questions
  accepts_nested_attributes_for :questions
  validates :title, presence: true

  # 検索方法　引数キーワードがある場合inqueryのtitleまたはquestionのquestionに部分一致するか、かつ引数titleがある場合inqueryのタイトル(:id)で絞る
  def self.search(key_word, title)
    return Inquery.all unless key_word.present? || title.present?
    Inquery.eager_load(:questions)
      .where(['question LIKE ? OR title LIKE ?', "%#{key_word}%", "%#{key_word}%"])
      .where(id: title)
  end
end
