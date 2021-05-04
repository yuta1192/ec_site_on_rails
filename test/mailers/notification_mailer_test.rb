require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  def send_password_reset_to_user
    @user = User.first
    ActionMailer::Base.mail(
      subject: "パスワードの変更先リンクを送信しました。", #メールのタイトル
      from: "hogehoge@example.com",
      to: @user.e_mail #宛先
    ) do |format|
      format.text
    end
  end
end
