class Admin::UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_params)
      flash[:notice] = "更新しました。"
      redirect_to edit_admin_user_path
    else
      # todo バリデーションのエラーを返す
      @errors = ["バリデーションのエラーを返す"]
      render 'edit'
    end
  end

  def password_reset
    @user = current_user
  end

  def reset
    @user = current_user
    if @user.authenticate(password_params[:password]) && (password_params[:new_password] == password_params[:password_confirmation]) && (password_params[:new_password] != nil)
      if @user.update_attributes(password: password_params[:new_password])
        flash[:notice] = "更新しました。"
        redirect_to password_reset_admin_user_path
      else
        # todo era-
        @error = "error"
        render 'password_reset'
      end
    else
      @error = "error"
      render 'password_reset'
    end
  end

  private

    def update_params
      params.require(:user).permit(:e_mail, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :tel, :phone_number, :fax)
    end

    def password_params
      params.require(:user).permit(:password, :new_password, :password_confirmation)
    end
end
