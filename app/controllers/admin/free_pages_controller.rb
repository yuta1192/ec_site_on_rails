class Admin::FreePagesController < ApplicationController
  def index
    @free_pages = FreePage.all.order(is_release_flg: :desc).order(:place).order(:display_order)
  end

  def new
    @free_page = FreePage.new
    @free_page.page_contents.build
    @page_count = @page_count.blank? ? 1 : @page_count
  end

  def edit
    @free_page = FreePage.find(params[:id])
    @page_contents = @free_page.page_contents
  end

  def destroy
    @free_page = FreePage.find(params[:id])
    if @free_page.destroy
      redirect_to admin_free_pages_path
    else
      @error = @free_page.errors.first
      render 'index' and return
    end
  end

  def create
    if (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "true")
      @place = 3
    elsif (params[:free_page][:place_header] == "false" && params[:free_page][:place_footer] == "true")
      @place = 2
    elsif (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "false")
      @place = 1
    else
      @place = 0
    end
    @free_page = FreePage.new(free_page_attributes)
    if @free_page.save
      redirect_to edit_admin_free_page_path(@free_page)
    else
      render 'new' and return
    end
  end

  def update
    @free_page = FreePage.find(params[:id])
    if (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "true")
      @place = 3
    elsif (params[:free_page][:place_header] == "false" && params[:free_page][:place_footer] == "true")
      @place = 2
    elsif (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "false")
      @place = 1
    else
      @place = 0
    end
    if @free_page.update(free_page_attributes)
      redirect_to edit_admin_free_page_path(params[:free_page][:free_page_id])
    else
      render 'edit' and return
    end
  end

  def change_release
    @free_pages = FreePage.all.order(is_release_flg: :desc).order(:place).order(:display_order)

    ActiveRecord::Base.transaction do
      @free_page = FreePage.find(params[:id])
      if @free_page.blank?
        @error = "選択したページが見つかりませんでした。画面を更新してください。"
        render 'index' and return
      end
      release_flg = @free_page.is_release_flg
      # release_flgがtrueならfalseに、falseならtrue
      change_flg = release_flg == true ? false : true

      @free_page.update!(is_release_flg: change_flg)
    end
      redirect_to admin_free_pages_path
  rescue
    @error = "システムエラーが発生しました。管理者に問い合わせてください。"
    render 'index'
  end

  def edit_change
    @id = params[:free_page][:id].present? ? params[:free_page][:id] : params[:id]
    redirect_to edit_admin_free_page_path(@id)
  end

  private

  def free_page_attributes
    params.require(:free_page).permit(:is_release_flg, :is_login_flg, :page_title, :h1_tag, :url, :display_order).merge(place: @place)
  end

  def page_content_attributes
    params.permit(:free_page)
  end
end
