class Admin::MembersController < ApplicationController
  def index
    @users = User.all
  end

  def search
    @user_params = search_params
    @users = User.search(@user_params)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:member_stop].present?
      if @user.update!(status: 3)
        redirect_to admin_members_path
      else
        render 'show'
      end
    else
      render 'show' and return if (join_params[:zip_code_front] || join_params[:zip_code_back] || join_params[:tel_first] || join_params[:tel_second] || join_params[:tel_third] || join_params[:phone_number_first] || join_params[:phone_number_second] || join_params[:phone_number_third] || join_params[:fax_first] || join_params[:fax_second] || join_params[:fax_third]).blank?
      ActiveRecord::Base.transaction do
        @zip_code = %W(#{join_params[:zip_code_front]} #{join_params[:zip_code_back]}).join
        @tel = %W(#{join_params[:tel_first]} #{join_params[:tel_second]} #{join_params[:tel_third]}).join
        @phone_number = %W(#{join_params[:phone_number_first]} #{join_params[:phone_number_second]} #{join_params[:phone_number_third]}).join
        @fax = %W(#{join_params[:fax_first]} #{join_params[:fax_second]} #{join_params[:fax_third]}).join
        @user.update(member_update_params)
        @user.update(zip_code: @zip_code, tel: @tel, phone_number: @phone_number, fax: @tel)
      end
      redirect_to admin_members_path
    end
  end

  def destroy
  end

  private

  def member_update_params
    params.require(:user).permit(:company_name, :company_name_kana, :company_code, :department_name, :department_code, :rank, :member_code, :e_mail, :password, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :prefectures, :municipation, :address_1, :address_2, :payment_method, :remark, :deadline)
  end

  def join_params
    params.require(:user).permit(:zip_code_front, :zip_code_back, :tel_first, :tel_second, :tel_third, :phone_number_first, :phone_number_second, :phone_number_third, :fax_first, :fax_second, :fax_third)
  end

  def search_params
    params.require(:user).permit(:keyword, :status, :prefectures, :start_date, :end_date, :rank)
  end
end
