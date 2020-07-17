class CreatePostages < ActiveRecord::Migration[5.2]
  def change
    create_table :postages do |t|
      t.string :hokkaido
      t.string :aomori
      t.string :iwate
      t.string :miyagi
      t.string :akita
      t.string :yamagata
      t.string :hukushima
      t.string :ibaragi
      t.string :totigi
      t.string :gunma
      t.string :saitama
      t.string :chiba
      t.string :tokyo
      t.string :kanagawa
      t.string :nigata
      t.string :toyama
      t.string :ishikawa
      t.string :hukui
      t.string :yamanashi
      t.string :nagano
      t.string :gihu
      t.string :sizuoka
      t.string :aichi
      t.string :mie
      t.string :shiga
      t.string :kyoto
      t.string :osaka
      t.string :hyogo
      t.string :nara
      t.string :wakayama
      t.string :tottori
      t.string :shimane
      t.string :okayama
      t.string :hiroshima
      t.string :yamaguchi
      t.string :tokushima
      t.string :kagawa
      t.string :ehime
      t.string :kochi
      t.string :hukuoka
      t.string :saga
      t.string :nagasaki
      t.string :kumamoto
      t.string :oita
      t.string :miyagi
      t.string :kagoshima
      t.string :okinawa
      t.timestamps
    end
  end
end
