class Admin::SessionsController < ApplicationController
  before_action :login_user, only: [:login]
  skip_before_action :require_sign_in!, only: [:index, :login, :password_reset, :complite_message]

  def index
  end

  # パスワード再設定のメール完了したページ用
  def complite_message
  end

  # パスワードの再設定をメールアドレスに送る機能
  def password_reset
    @emails = User.where(admin: true).pluck(:e_mail)
    if @emails.include?(params[:session][:e_mail])
      # todo ここにメール返信処理を追加すること
      redirect_to admin_complite_message_path
    else
      flash.now[:alert] = "メールアドレスを正しく入力してください。"
      render 'index'
    end
  end

  def login
    if @user.present? && @user.authenticate(login_params[:password])
      sign_in(@user)
      redirect_to admin_dashboard_path
    else
      @error = "メールアドレスまたはパスワードを正しく入力してください。"
      render 'index'
    end
  end

  def logout
    sign_out
    redirect_to admin_login_path
  end

  private

    def login_user
      @user = User.find_by(e_mail: login_params[:e_mail], admin: true)
    end

    def login_params
      params.require(:session).permit(:e_mail, :password)
    end
end
