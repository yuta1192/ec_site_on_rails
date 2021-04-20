# 新着情報系(InfoTitle, Information)

5.times do |i|
  Information.seed do |info|
    info.detail = "information_#{i}"
    info.release_flg = [true, false].sample
    info.date = Date.today
    info.published_start_yyyymmdd = "2020/10/10"
    info.published_start_hhmm = "2020"
    info.published_end_yyyymmdd = "2020/10/10"
    info.published_end_hhmm = "2020"
  end

  InfoTitle.seed do |it|
    it.title = "info_title_#{i}"
    it.hyoji_count = i+1
  end
end
