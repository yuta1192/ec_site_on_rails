class Admin::ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
  end

  def destroy
  end

  def banner
  end

  def banner_edit
  end
end
