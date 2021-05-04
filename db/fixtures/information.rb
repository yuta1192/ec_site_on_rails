# 新着情報系(InfoTitle, Information)

5.times do |i|
  Information.seed do |info|
    info.detail = "information_#{i}"
    info.release_flg = [true, false].sample
    info.date = Date.today
    info.published_start = DateTime.now
    info.published_end = DateTime.now.prev_year(5)
  end

  InfoTitle.seed do |it|
    it.title = "info_title_#{i}"
    it.hyoji_count = i+1
  end
end
