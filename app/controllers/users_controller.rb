class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to sessions_path
    else
      render 'new'
    end
  end

  def password_edit
  end

  def password_reset
    @user = @current_user
    if @user.authenticate(user_password_params[:password]) && (user_password_params[:new_password] == user_password_params[:password_confirmation]) && (user_password_params[:new_password] != nil)
      if @user.update_attributes(password: user_password_params[:new_password])
        redirect_to mypage_path
      else
        render 'password_edit'
      end
    else
      render 'password_edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name_sei, :email, :password, :password_confirmation, :cart_id)
    end

    # password_resetのストロングパラメータ
    def user_password_params
      params.permit(:password, :new_password, :password_confirmation)
    end
end
