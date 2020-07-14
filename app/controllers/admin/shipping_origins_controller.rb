class Admin::ShippingOriginsController < ApplicationController
  def index
    @shipping_origins = ShippingOrigin.all
  end

  def new
    @shipping_origin = ShippingOrigin.new
  end

  def search
    @shipping_origin_params = search_params
    @shipping_origins = ShippingOrigin.search(@shipping_origin_params)
  end

  def show
    @shipping_origin = ShippingOrigin.find(params[:id])
  end

  def update
    @shipping_origin = ShippingOrigin.find(params[:id])
    if params[:status_change].present?
      update_status = @shipping_origin.status == 1 ? 2 : 1
      if @shipping_origin.update!(status: update_status)
        redirect_to admin_shipping_origin_path(@shipping_origin)
      else
        render 'show'
      end
    else
      if @shipping_origin.update!(update_params)
        redirect_to admin_shipping_origin_path(@shipping_origin)
      else
        render 'show'
      end
    end
  end

  def destroy
    @shipping_origin = ShippingOrigin.find(params[:id])
    if @shipping_origin.delete!
      redirect_to admin_shipping_origins_path
    else
      render 'index'
    end
  end

  def create
    @shipping_origin = ShippingOrigin.new(create_params)
    if @shipping_origin.save!
      redirect_to admin_shipping_origin_path(@shipping_origin)
    else
      render 'new'
    end
  end

  private

  def search_params
    params.require(:shipping_origin).permit(:origin_id, :status, :shipping_origin_name)
  end

  def update_params
    params.require(:shipping_origin).permit(:password_digest, :shipping_origin_email, :shipping_origin_name)
  end

  def create_params
    params.require(:shipping_origin).permit(:password_digest, :shipping_origin_email, :shipping_origin_name, :origin_id, :status)
  end
end
