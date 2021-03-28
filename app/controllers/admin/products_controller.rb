class Admin::ProductsController < ApplicationController
  def index
    params[:page] = params[:page].blank? ? 1 : params[:page]
    params[:per] = params[:per].blank? ? 50 : params[:per]

    products = Product.all
    @products_count = products.count
    @products = products.page(params[:page]).per(params[:per])

    @category = Product.select(:category_id).distinct
  end

  def search
    # 初期値がない場合は設定する
    params[:page] = params[:page].blank? ? 1 : params[:page]
    params[:per] = params[:per].blank? ? 50 : params[:per]
    @page = params[:page]
    @per = params[:per]

    products = Product.search(products_search_params[:name]).category_name_search(products_search_params[:category_name]).product_number_search(products_search_params[:product_number]).jan_code_search(products_search_params[:jan_code]).manufacturer_search(products_search_params[:manufacturer]).where(new_flg: products_search_params[:new_flg]).where(popular_flg: products_search_params[:popular_flg]).except_no_stock(products_search_params[:stock])

    @products_count = products.count
    @products = products.page(@page).per(@per)

    @category = Product.select(:category_id).distinct
    @category_name = select_categories_name

    @params = {product_number: params[:product][:product_number], name: params[:product][:name], jan_code: params[:product][:jan_code], new_flg: params[:product][:new_flg], popular_flg: params[:product][:popular_flg], stock: params[:product][:stock], category_name: params[:product][:category_name], manufacturer: params[:product][:manufacturer]}
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    parameter_setting
    @product = Product.find(params[:id])
    if @product.update!(update_product_params)
      redirect_to edit_admin_product_path(@product)
    else
    end
  end

  def create
    parameter_setting
    @product = Product.new(create_product_params)
    if @product.save!
      redirect_to edit_admin_product_path(@product)
    else
    end
  end

  def category
    select_categories_name = []
    Category.all.each do |c|
      select_categories_name << [c.name, c.id]
    end
    @categories = select_categories_name
  end

  def category_edit
    if params[:category][:id].present?
      @category = Category.find(params[:category][:id])
    else
      @category = Category.new
    end
  end

  def category_update
    @category = Category.find(params[:category][:id])
    @child_category =
    @category.child_categories.present? ? @category.child_categories.find(params[:category][:child_categories][:id]) : ChildCategory.new(category_id: @category.id, name: category_params[:child_categories][:name])
    ActiveRecord::Base.transaction do
      @category.update!(name: category_params[:name])
      if @child_category.id == nil
        @child_category.save!
      else
        @child_category.update!(name: category_params[:child_categories][:name])
      end
    end
    redirect_to category_admin_products_path
  end

  def category_create
    @category = Category.new(name: category_params[:name])
    ActiveRecord::Base.transaction do
      @category.save!
      @child_category = ChildCategory.new(name: category_params[:child_categories][:name], category_id: @category.id)
      @child_category.save!
    end
    redirect_to category_admin_products_path
  end

  private

  def parameter_setting
    @tax_flg = params[:product][:tax_flg] == "1" ? true : false
    @remote_island_shipping_confirmation = params[:product][:remote_island_shipping_confirmation] == "1" ? true : false
    display_period_start_to_s = params[:product][:display_period_start_yyyy_mm_dd] + params[:product][:display_period_start_hh_mm]
    @display_period_start = DateTime.parse(display_period_start_to_s)
    display_period_end_to_s = params[:product][:display_period_end_yyyy_mm_dd] + params[:product][:display_period_end_hh_mm]
    @display_period_end = DateTime.parse(display_period_end_to_s)
  end

  def create_product_params
    params.require(:product).permit(:is_release_flg, :product_number, :name, :notification_email, :new_flg, :popular_flg, :comment, :explanation_1, :explanation_2, :manufacturer, :category_name, :purchase_limit, :postage_comment).merge(remote_island_shipping_confirmation: @remote_island_shipping_confirmation, tax_flg: @tax_flg, display_period_start: @display_period_start, display_period_end: @display_period_end)
  end

  def update_product_params
    params.require(:product).permit(:is_release_flg, :product_number, :name, :notification_email, :new_flg, :popular_flg, :comment, :explanation_1, :explanation_2, :manufacturer, :category_name, :purchase_limit, :postage_comment).merge(remote_island_shipping_confirmation: @remote_island_shipping_confirmation, tax_flg: @tax_flg, display_period_start: @display_period_start, display_period_end: @display_period_end)
  end

  def products_search_params
    params.require(:product).permit(:product_number, :name, :jan_code, :new_flg, :popular_flg, :category_name, :manufacturer, :stock)
  end

  # def select_categories_name
  #   a = []
  #   Category.all.each do |c|
  #     a << [c.name, c.id]
  #   end
  # end

  def category_params
    params.require(:category).permit(:id, :name, child_categories: [:id, :name])
  end
end
