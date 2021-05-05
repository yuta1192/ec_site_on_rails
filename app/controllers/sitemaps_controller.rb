class SitemapsController < ApplicationController
  include ApplicationHelper

  def sitemap
    @sitemap = Sitemap.all
    @freepages = FreePage.all
    @categories = Category.all
  end
end
