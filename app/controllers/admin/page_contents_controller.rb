class Admin::PageContentsController < ApplicationController
  def destroy
    @page_content = PageContent.find(params[:id])
    if @page_content.destroy
      redirect_to edit_admin_free_page_path(params[:free_page_id])
    else
      render edit
    end
  end

  def create
    @page_content = PageContent.new(free_page_id: params[:id])
    if @page_content.save
      redirect_to edit_admin_free_page_path(params[:id])
    else
      @error = "エラー"
      redirect_to edit_admin_free_page_path(params[:id])
    end
  end

  def update
    ActiveRecord::Base.transaction do
      params[:free_page][:page_contents_attributes].keys.each do |i|
        @page_content = PageContent.find(params[:free_page][:page_contents_attributes][i][:id])
        @page_content.update(
          title: params[:free_page][:page_contents_attributes][i][:title],
          sentence: params[:free_page][:page_contents_attributes][i][:sentence]
        )
      end
    end
    redirect_to edit_admin_free_page_path(params[:id])
  rescue => e
    @error = "error"
    redirect_to edit_admin_free_page_path(params[:id])
  end
end
