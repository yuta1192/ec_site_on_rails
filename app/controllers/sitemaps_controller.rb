class SitemapsController < ApplicationController
  def sitemap
    @sitemap = Sitemap.all
  end
end
