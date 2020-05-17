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
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to edit_user_address_path(@address)
    else
      render 'edit'
    end
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to edit_user_address_path(user_id: @current_user,id: @address.id)
    else
      render 'new'
    end
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
      params.require(:address).permit(:company_name, :department_name, :name_sei, :name_mei, :name_sei_kana, :name_mei_kana, :zip_code, :prefectures, :municipation, :address_1, :address_2, :tel, :phone_number, :user_id)
    end
end
