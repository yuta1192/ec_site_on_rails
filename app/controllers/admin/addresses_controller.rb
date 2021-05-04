class Admin::AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def new
    @user = params[:user].present? ? User.find(params[:user]) : nil
    @address = Address.new
  end

  def user_search
    @users = User.all
  end

  def search
    @address_params = search_params
    @users = User.address_search(@address_params)
    @address = Address.address_search(@address_params)
  end

  def show
    @address = Address.find(params[:id])
    @user = User.find(@address.user_id)
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(update_params)
      redirect_to admin_addresses_path
    else
      render 'show'
    end
  end

  def create
    @address.new(create_params)
    @user = params[:user].present? ? User.find(params[:user]) : nil

    if @user.blank?
      # todo era-bun
      @error = "era-"
      render 'new' and return
    end

    if @address.save
      redirect_to admin_address_path
    else
      render 'new'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.delete
      redirect_to admin_addresses_path
    else
      render 'index'
    end
  end

  private

  def search_params
    params.require(:user).permit(:keyword)
  end

  def update_params
    params.require(:address).permit(:company_name, :department_name, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :zip_code, :prefectures, :municipation, :address_1, :address_2, :tel, :phone_number)
  end

  def create_params
    params.require(:address).permit(:company_name, :department_name, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :zip_code, :prefectures, :municipation, :address_1, :address_2, :tel, :phone_number).marge(user_id: params[:user_id])
  end
end
