class PageContent < ApplicationRecord
  # ページコンテンツ（free_pageの中身の文章)
  # free_page_idを必ず一つだけ所有している)

  # title コンテンツのタイトル
  # sentence コンテンツの文章
  # free_page_id 親のFreePageのID

  belongs_to :free_page
  validates :title, presence: true
  validates :sentence, presence: true
end
