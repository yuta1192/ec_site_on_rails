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
    PageContent.create(free_page_id: params[:page_content][:free_page_id])
    redirect_to edit_admin_free_page_path(params[:page_content][:free_page_id])
  end
end
