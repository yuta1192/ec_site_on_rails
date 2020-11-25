class Admin::ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    if Image.create(banner_upload)
      redirect_to admin_images_path
    else
      return render index
    end
  end

  def destroy
  end

  def banner_index
    # ここセレクトで選ばれたものをidに
    @images = Image.where(banner_id: 1)
  end

  def banner_create
    Banner.create(image: params[:banner][:image], name: "banana1", hyoji_area: 2, comment: "バナー下")
    redirect_to root_path
  end

  def banner_update
    banner = Banner.find_by(id: params[:banner][:banner_id])
    if banner.update!(name: params[:banner][:banner_name])
      redirect_to admin_banner_index_path
    else
      render admin_banner_index_path
    end
  end

  private

  def banner_upload
    params.require(:image).permit(:image)
  end
end
