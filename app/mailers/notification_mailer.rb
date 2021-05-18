class NotificationMailer < ApplicationMailer
  default from: MailSetting.first.base_mail_address

  def send_password_reset_to_user(user)
    @user = user
    mail(
      subject: "パスワードの変更先リンクを送信しました。", #メールのタイトル
      to: @user.email #宛先
    ) do |format|
      format.text
    end
  end

  def user_send_contact(user, contact)
    @user = user
    @contact = contact
    mail(
      subject: "#{@user.name_sei + @user.name_mei}様からお問い合わせがあります。",
      from: @user.email,
      to: User.find_by(admin: true).email
    ) do |format|
      format.text
    end
  end

  def send_purchase_complite(user, order_history)
    @user = user
    @order = order_history
    mail(
      subject: "商品を購入しました。",
      to: @user.email
    ) do |format|
      format.text
    end
  end
end
