class Admin::ImagesController < ApplicationController
  def index
    # 初期値がない場合は設定する
    params[:page] = params[:page].blank? ? 1 : params[:page]
    params[:per] = params[:per].blank? ? 25 : params[:per]
    @page = params[:page]
    @per = params[:per]

    @image = Image.new
    @images = Image.all.page(@page).per(@per)
  end

  def create
    @images = Image.all.page(@page).per(@per)
    @image = Image.new(
      image: params[:image][:image],
      name: params[:image][:image].original_filename,
      comment: params[:image][:comment],
      is_banner_flg: params[:image][:is_banner_flg]
    )
    if @image.save
      binding.pry
      url = @image.image.file.file
      if @image.update(url: url)
        redirect_to admin_images_path
      else
        render 'index' and return
      end
    else
      render 'index' and return
    end
  end

  def destroy
  end

  def banner_index
    @images = Image.all
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
