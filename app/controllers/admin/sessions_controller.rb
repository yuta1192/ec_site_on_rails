class Admin::SessionsController < ApplicationController
  before_action :login_user, only: [:login]
  skip_before_action :require_sign_in!, only: [:index, :login]

  def index
  end

  def login
    if @user.authenticate(login_params[:password])
      sign_in(@user)
      redirect_to admin_dashboard_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      redirect_to '/login'
    end
  end

  def logout
    sign_out
    redirect_to admin_login_path
  end

  private

    def login_user
      @user = User.find_by(e_mail: login_params[:e_mail])
    rescue
      flash.now[:danger] = "fuck"
      render action: 'index'
    end

    def login_params
      params.require(:session).permit(:e_mail, :password)
    end
end
