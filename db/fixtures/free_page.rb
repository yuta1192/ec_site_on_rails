# ページ管理（FreePage, PageContent）

flg = [true, false]

4.times do |f|
  FreePage.seed do |fp|
    fp.page_title = "page_title_#{f}"
    fp.h1_tag = 'h1_tag'
    fp.url = "url_#{f}"
    fp.place = f
    fp.is_release_flg = flg.sample
    fp.is_login_flg = flg.sample
    fp.display_order = f+1
  end

  PageContent.seed do |pc|
    pc.title = "title_#{f}"
    pc.sentence = "sentence_#{f}"
    pc.free_page_id = f+1
  end
end
