class SitemapsController < ApplicationController
  def sitemap
    @sitemap = Sitemap.all
    @freepages = FreePage.all
    @categories = Category.all
  end
end
