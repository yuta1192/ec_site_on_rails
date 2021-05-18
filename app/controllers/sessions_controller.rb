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
    @emails = User.where(admin: false).pluck(:email)
    if @emails.include?(params[:session][:email])
      @user = User.find_by(email: params[:session][:email])
      NotificationMailer.send_password_reset_to_user(@user).deliver
      redirect_to complite_message_path
    else
      flash.now[:alert] = "メールアドレスを正しく入力してください。"
      render 'index'
    end
  end

  def reset_password
    @user = User.find_by(id: params[:user_id], email: params[:email])
    unless params[:token] == true
      @error = "権限がありません"
      render 'index'
    end
  end

  def reset_user_password
    @user = User.find_by(id: params[:user_id], email: params[:email])
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

  # oauth
  def new
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    # has_secure_passwordでパスワード必須のため
    user.password = SecureRandom.hex(9)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

    def login_user
      @user = User.find_by(email: login_params[:email], admin: false)
    end

    def login_params
      params.require(:session).permit(:email, :password)
    end

    # ログインしている場合はroot_pathに戻す
    def back_root_path
      redirect_to root_path if signed_in?
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
