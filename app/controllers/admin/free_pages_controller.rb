class Admin::FreePagesController < ApplicationController
  def index
    @free_pages = FreePage.all
  end
end
