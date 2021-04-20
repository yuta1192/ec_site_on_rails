class TopPagesController < ApplicationController
  def index
    @product_categories = Category.all
    @new_products = Product.last(3).reverse
    @informations = Information.where(release_flg: true)
      # .where("#{Time.zone.now} >= ?", Time.zone.parse(published_start) )
      # .where("#{Time.zone.now} <= ?", Time.zone.parse(published_end) )

      # from = published_start_yyyymmdd + published_start_hhmm
      # to = published_end_yyyymmdd + published_end_hhmm
  end
end
