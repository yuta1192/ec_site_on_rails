class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def sign_out
    @current_user.forget
    @current_user = nil
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:user_remember_token)
  end

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      return @current_user
    end
    remember_token = cookies[:user_remember_token].present? ? User.encrypt(cookies[:user_remember_token]) : "no_remember_token"
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    @current_user.present?
  end

  private

    def require_sign_in!
      # adminでログインしてない場合はadminのログイン画面にそれ以外は利用者画面
      if params[:controller].include?("admin")
        redirect_to admin_login_path unless signed_in?
      else
        redirect_to login_path unless signed_in?
      end
    end
end
