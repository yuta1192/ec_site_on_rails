class Admin::FreePagesController < ApplicationController
  def index
    @free_pages = FreePage.all.order(is_release_flg: :desc).order(:place).order(:display_order)
  end

  def new
    @free_page = FreePage.new
  end

  def edit
    if params[:free_page].present?
      @free_page = FreePage.find(params[:free_page][:id])
    else
      @free_page = FreePage.find(params[:id])
    end
    @page_contents = @free_page.page_contents
  end

  def destroy

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
    free_page = FreePage.new(free_page_attributes)
    if free_page.save!
      redirect_to edit_admin_free_page_path(free_page)
    else
    end
  end

  def update
    if (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "true")
      @place = 3
    elsif (params[:free_page][:place_header] == "false" && params[:free_page][:place_footer] == "true")
      @place = 2
    elsif (params[:free_page][:place_header] == "true" && params[:free_page][:place_footer] == "false")
      @place = 1
    else
      @place = 0
    end
    ActiveRecord::Base.transaction do
      free_page = FreePage.find(params[:id])
      free_page.update(free_page_attributes)
      params[:free_page][:page_contents].keys.each do |i|
        page_content = PageContent.find(i)
        page_content.update(title: params[:free_page][:page_contents][i][:title], sentence: params[:free_page][:page_contents][i][:sentence])
      end
    end

    redirect_to edit_admin_free_page_path(params[:free_page][:free_page_id])
  end


  private

  def free_page_attributes
    params.require(:free_page).permit(:is_release_flg, :is_login_flg, :page_title, :h1_tag, :url, :display_order).merge(place: @place)
  end

  def page_content_attributes
    params.permit(:free_page)
  end
end
