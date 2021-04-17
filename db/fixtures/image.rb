# ロゴ画像系、バナー系(Image, Banner)

3.times do |p|
  Image.seed do |i|
    i.image = File.open(["./db/fixtures/image_file/014.jpg","./db/fixtures/image_file/5503321i.jpeg","./db/fixtures/image_file/arm_tablet (1).png","./db/fixtures/image_file/karaoke.png","./db/fixtures/image_file/shopping_supermarket_man.png","./db/fixtures/image_file/shopping_supermarket_family_mother.png","./db/fixtures/image_file/yusyou_champagne_fight.png"].sample)
    i.url = "url_#{p}"
    i.name = "name_#{p}"
    i.is_banner_flg = [true,false].sample
    i.comment = "comment_#{p}"
  end
end

5.times do |i|
  Banner.seed do |b|
    b.name = "banner_name_#{i}"
    b.comment = "banner_comment_#{i}"
    b.image_id = [1,2,3].sample
  end
end
