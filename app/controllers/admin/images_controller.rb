class Admin::ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
  end

  def destroy
  end

  def banner_index
    # ここセレクトで選ばれたものをidに
    @images = Image.where(banner_id: 1)
  end

  def banner
  end

  def banner_update
    banner = Banner.find_by(id: params[:banner][:banner_id])
    if banner.update!(name: params[:banner][:banner_name])
      redirect_to admin_banner_index_path
    else
      render admin_banner_index_path
    end
  end
end
