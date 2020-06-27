class Admin::ProductPagesController < ApplicationController
  def edit
    if ProductPage.first
      @product_page = ProductPage.first
    else
      @product_page = ProductPage.new
    end
  end

  def create
    if ProductPage.first
      @product_page = ProductPage.first
      @product_page.update(up_page_text: params[:product_page][:up_page_text], bottom_page_text: params[:product_page][:bottom_page_text])
      redirect_to admin_product_page_edit_path
    else
      ProductPage.create(up_page_text: params[:product_page][:up_page_text], bottom_page_text: params[:product_page][:bottom_page_text])
      redirect_to admin_product_page_edit_path
    end
  end
end
