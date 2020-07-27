class FreePagesController < ApplicationController
  def index
    @freepage = FreePage.find_by(url: params[:url_value])
  end
end
