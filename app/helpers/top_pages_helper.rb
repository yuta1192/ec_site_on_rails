module TopPagesHelper
  # 下のバナー作成
  def banner_under
    Banner.where(hyoji_area: 2)
  end
end
