class User < ApplicationRecord
#  has_many :addresses
#  has_many :order_histories
  belongs_to :cart
  has_many :addresses
#  has_many :contact
#  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password validations: true
  validates :e_mail, presence: true, uniqueness: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  scope :search, -> (user_params) do
    return if user_params.blank?

    #keywords_search(user_params[:keyword])
    status_search(user_params[:status])
      .prefectures_search(user_params[:prefectures])
      .start_date_search(user_params[:start_date])
      .end_date_search(user_params[:end_date])
      .rank_search(user_params[:rank])
  end

  #scope :keywords_search, -> keyword {}
  scope :status_search, -> status { where(status: status) }
  scope :prefectures_search, -> prefectures { where(prefectures: prefectures) if prefectures.present? }
  scope :start_date_search, -> start_date { where('created_at <= ?', start_date) if start_date.present? }
  scope :end_date_search, -> end_date { where('? <= created_at', end_date) if end_date.present? }
  scope :rank_search, -> rank { where(rank: rank) if rank.present? }

  scope :users_search, -> (group_users_params) do
    return if group_users_params.blank?

    #keywords_search(user_params[:keyword])
    member_code_search(group_users_params[:member_code])
      .company_name_search(group_users_params[:company_name])
      .department_name_search(group_users_params[:department_name])
      .name_sei_search(group_users_params[:name_sei])
      .name_mei_search(group_users_params[:name_mei])
      .zip_code_search(group_users_params[:zip_code_first], group_users_params[:zip_code_second])
      .e_mail_search(group_users_params[:e_mail])
      .tel_search(group_users_params[:tel_first], group_users_params[:tel_second], group_users_params[:tel_third])
  end

  scope :member_code_search, -> member_code { where('member_code LIKE ?', "%#{member_code}%") if member_code.present? }
  scope :company_name_search, -> company_name { where('company_name LIKE ?', "%#{company_name}%") if company_name.present? }
  scope :department_name_search, -> department_name { where('department_name LIKE ?', "%#{department_name}%") if department_name.present? }
  scope :name_sei_search, -> name_sei { where('name_sei LIKE ?', "%#{name_sei}%") if name_sei.present? }
  scope :name_mei_search, -> name_mei { where('name_mei LIKE ?', "%#{name_mei}%") if name_mei.present? }
  scope :zip_code_search, -> zip_code_first, zip_code_second { where('zip_code LIKE ?', "%#{%W(#{zip_code_first} #{zip_code_second}).join}%") if zip_code_first.present? && zip_code_second.present? }
  scope :e_mail_search, -> e_mail { where('e_mail LIKE ?', "%#{e_mail}%") if e_mail.present? }
  scope :tel_search, -> tel_first, tel_second, tel_third { where('tel LIKE ?', "%#{%W(#{tel_first} #{tel_second} #{tel_third}).join}%") if tel_first.present? && tel_second.present? && tel_third.present? }

  scope :address_search, -> (address_params) do
    return if address_params.blank?
    keyword_search(address_params[:keyword])
  end

  scope :keyword_search, -> keyword { where(tel: keyword) if keyword.present? } #仮　適当に

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

  enum rank: {
    一般顧客:1,大口顧客:2,プレミア顧客:3,会員ランク4:4,会員ランク5:5,会員ランク6:6,会員ランク7:7,会員ランク8:8,会員ランク9:9,会員ランク10:10
  }
end
