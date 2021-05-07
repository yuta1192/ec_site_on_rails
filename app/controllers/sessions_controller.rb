class SessionsController < ApplicationController
  before_action :login_user, only: [:login]
  before_action :back_root_path, only: [:index, :login, :password_reset, :complite_message, :reset_password, :reset_user_password]
  skip_before_action :require_sign_in!, only: [:index, :login, :password_reset, :complite_message, :reset_password, :reset_user_password]

  def index
  end

  # パスワード再設定のメール完了したページ用
  def complite_message
  end

  # パスワードの再設定をメールアドレスに送る機能
  def password_reset
    @emails = User.where(admin: false).pluck(:e_mail)
    if @emails.include?(params[:session][:e_mail])
      @user = User.find_by(e_mail: params[:session][:e_mail])
      NotificationMailer.send_password_reset_to_user(@user).deliver
      redirect_to complite_message_path
    else
      flash.now[:alert] = "メールアドレスを正しく入力してください。"
      render 'index'
    end
  end

  def reset_password
    @user = User.find_by(id: params[:user_id], e_mail: params[:e_mail])
    unless params[:token] == true
      @error = "権限がありません"
      render 'index'
    end
  end

  def reset_user_password
    @user = User.find_by(id: params[:user_id], e_mail: params[:e_mail])
    if params[:user][:password].blank? || params[:user][:password_confirmation].blank?
      @error = "パスワードとパスワード確認を記載してください。"
      render 'reset_password'
    elsif params[:user][:password] != params[:user][:password_confirmation]
      @error = "パスワードとパスワード確認が一致しません。"
      render 'reset_password'
    elsif @user.update_attributes(user_params)
      # todo メッセージ出てこないのでトップ画面に出るように変更
      flash[:success] = "パスワードを再設定が完了しました。再設定したパスワードでログインしてください。"
      redirect_to login_path
    else
      @error = "システムエラーが発生しました。もう一度入力してください。"
      render 'reset_password'
    end
  end

  def login
    if @user.present? && @user.authenticate(login_params[:password])
        sign_in(@user)
        redirect_to root_path
    else
      @error = "メールアドレスまたはパスワードを正しく入力してください。"
      render 'index'
    end
  end

  def logout
    sign_out
    redirect_to login_path
  end

  private

    def login_user
      @user = User.find_by(e_mail: login_params[:e_mail], admin: false)
    end

    def login_params
      params.require(:session).permit(:e_mail, :password)
    end

    # ログインしている場合はroot_pathに戻す
    def back_root_path
      redirect_to root_path if signed_in?
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
