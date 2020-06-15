class Admin::InformationsController < ApplicationController
  def index
    @informations = Information.all
  end

  def edit
    
  end

  def destroy
  end
end
