class AddressesController < ApplicationController
  before_action :user_addresses

  def index
    @address = Address.new
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(address_params)
      # 正常終了
      redirect_to edit_user_address_path(@address)
    else
      render :edit and return
    end
  end

  def create
    # 5個以上は作れない
    if @addresses.count >= 5
      @address = Address.new
      @address.errors.add(:base, "お届け先はお一人様５つまでです。")
      render :new and return
    end

    @address = Address.new(address_params)
    if @address.save
      # 正常終了
      redirect_to edit_user_address_path(user_id: @current_user,id: @address.id)
    else
      render :new and return
    end

  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to user_addresses_path
    else
      render :edit
    end
  end

  private

    def address_params
      params.require(:address).permit(:company_name, :department_name, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :prefectures, :municipation, :address_1, :address_2, :phone_number, :user_id, :zip_code, :tel)
    end

    def user_addresses
      @addresses = @current_user.addresses
    end
end
