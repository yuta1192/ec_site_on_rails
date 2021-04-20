class Address < ApplicationRecord
  PHONE_REGEX = /\A[0-9][-0-9]+\z/ #先頭ハイフン以外かつ半角数字とハイフンのみ

  belongs_to :user

  # バリデーション
  validates :company_name, presence: true
  validates :zip_code, presence: true
  validates :prefectures, presence: true
  validates :municipation, presence: true
  validates :address_1, presence: true
  validates :tel, presence: true
  validates :phone_number, format: { with: PHONE_REGEX, message: '先頭ハイフン以外かつ半角数字と半角ハイフン(-)以外は使用できません。'}
  validate :zip_code_valid?

  # zip_codeのカスタムバリデーション
  def zip_code_valid?
    if zip_code.present? # zip_codeがない場合はvalidatesの方でエラーだす。
      if zip_code.include?('-')
        if zip_code.split('-')[0].present? && zip_code.split('-')[1].present?
          if zip_code.split('-')[0].length != 3 || zip_code.split('-')[1].length != 4
            errors.add(:zip_code, '郵便番号のフォーマットが間違っています。')
          end
        end
      else
        errors.add(:zip_code, '郵便番号のフォーマットが間違っています。')
      end
    end
  end

  scope :address_search, -> (address_params) do
    return if address_params.blank?
    keyword_search(address_params[:keyword])
  end

  scope :keyword_search, -> keyword { where(tel: keyword) if keyword.present? } #仮　適当

  enum prefectures: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
end
