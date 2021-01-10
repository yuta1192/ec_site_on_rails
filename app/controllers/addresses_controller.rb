class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def new
    @addresses = Address.all
  end

  def edit
    @addresses = Address.all
    @address = Address.find(params[:id])
  end

  def update
    # zip_code, telは複数にしているため結合する。
    zip_code = []
    zip_code << address_params[:zip_code_1]
    zip_code << address_params[:zip_code_2]
    ketugo_zip_code = zip_code.join('-')

    tel = []
    tel << address_params[:tel_1]
    tel << address_params[:tel_2]
    tel << address_params[:tel_3]
    ketugo_tel = tel.join('-')

    ActiveRecord::Base.transaction do
      @address = Address.find(params[:id])
      @address.update!(
        company_name: address_params[:company_name],
        department_name: address_params[:department_name],
        name_sei: address_params[:name_sei],
        name_mei: address_params[:name_mei],
        name_sei_kana: address_params[:name_sei_kana],
        name_mei_kana: address_params[:name_mei_kana],
        zip_code: ketugo_zip_code,
        prefectures: address_params[:prefectures],
        municipation: address_params[:municipation],
        address_1: address_params[:address_1],
        address_2: address_params[:address_2],
        tel: ketugo_tel,
        phone_number: address_params[:phone_number],
        user_id: address_params[:user_id]
      )
    end
      # 正常終了
      redirect_to edit_user_address_path(@address)
    rescue => e
      # エラー
      render 'edit'
  end

  def create
    # zip_code, telは複数にしているため結合する。
    zip_code = []
    zip_code << address_params[:zip_code_1]
    zip_code << address_params[:zip_code_2]
    ketugo_zip_code = zip_code.join('-')

    tel = []
    tel << address_params[:tel_1]
    tel << address_params[:tel_2]
    tel << address_params[:tel_3]
    ketugo_tel = tel.join('-')
    # phone_numberを整形する

    ActiveRecord::Base.transaction do
      @address = Address.new(
        company_name: address_params[:company_name],
        department_name: address_params[:department_name],
        name_sei: address_params[:name_sei],
        name_mei: address_params[:name_mei],
        name_sei_kana: address_params[:name_sei_kana],
        name_mei_kana: address_params[:name_mei_kana],
        zip_code: ketugo_zip_code,
        prefectures: address_params[:prefectures],
        municipation: address_params[:municipation],
        address_1: address_params[:address_1],
        address_2: address_params[:address_2],
        tel: ketugo_tel,
        phone_number: address_params[:phone_number],
        user_id: address_params[:user_id]
      )
      @address.save!
    end
      # 正常終了
      redirect_to edit_user_address_path(user_id: @current_user,id: @address.id)
    rescue => e
      # 異常
      render 'new'
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to user_addresses_path
    else
      render 'edit'
    end
  end

  private

    def address_params
      params.require(:address).permit(:company_name, :department_name, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :zip_code_1, :zip_code_2, :prefectures, :municipation, :address_1, :address_2, :tel_1, :tel_2, :tel_3, :phone_number, :user_id)
    end
end
