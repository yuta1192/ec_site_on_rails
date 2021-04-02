# ロゴ画像系、バナー系(Image, Banner)

5.times do |i|
  Banner.seed do |b|
    b.name = "banner_name_#{i}"
    b.image = File.open(['./public/uploads/product/image/1/something.jpg', './public/uploads/product/image/2/youtuber_mask_sunglass.png',
                        './public/uploads/product/image/3/otaku_fujoshi_winter.png', './public/uploads/product/image/4/bunbougu_nerikeshi.png',
                        './public/uploads/product/image/5/medical_virus_kouseibusshitsu_yakuzai_taiseikin.png'].sample)
    b.comment = "banner_comment_#{i}"
  end
end

3.times do |p|
  Image.seed do |i|
    i.image = File.open(['./public/uploads/product/image/1/something.jpg', './public/uploads/product/image/2/youtuber_mask_sunglass.png',
                        './public/uploads/product/image/3/otaku_fujoshi_winter.png', './public/uploads/product/image/4/bunbougu_nerikeshi.png',
                        './public/uploads/product/image/5/medical_virus_kouseibusshitsu_yakuzai_taiseikin.png'].sample)
    i.url = "url_#{p}"
    i.name = "name_#{p}"
    i.is_banner_flg = [true,false].sample
    i.comment = "comment_#{p}"
    i.banner_id = p+1
  end
end
