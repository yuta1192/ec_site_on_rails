class Admin::MembersController < ApplicationController
  def index
    @users = User.where(admin: false)
  end

  def search
    @users = User.search(search_params).where(admin: false)
  end

  def edit
    @user = User.find(params[:id])
  end

  # showじゃなくてeditに
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:member_stop].present?
      if @user.update(status: 3)
        redirect_to admin_members_path
      else
        render 'show'
      end
    else
      if @user.update(member_update_params)
        redirect_to admin_members_path
      else
        render 'show'
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      redirect_to admin_member_path(@user)
    else
      render 'new'
    end
  end

  def destroy
  end

  private

  def member_update_params
    params.require(:user).permit(:company_name, :company_name_kana, :company_code, :department_name, :department_code, :rank, :member_code, :e_mail, :password, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :prefectures, :municipation, :address_1, :address_2, :payment_method, :remark, :deadline, :zip_code, :tel, :phone_number, :fax)
  end

  def search_params
    params.require(:user).permit(:keyword, :status, :prefectures, :start_date, :end_date, :rank)
  end

  def create_params
    params.require(:user).permit(:company_name, :company_name_kana, :company_code, :department_name, :department_code, :rank, :member_code, :e_mail, :password, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :zip_code_front, :zip_code_back, :prefectures, :municipation, :address_1, :address_2, :tel_first, :tel_second, :tel_third, :phone_number_first, :phone_number_second, :phone_number_third, :fax_first, :fax_second, :fax_third, :payment_method, :deadline, :remark)
  end
end
