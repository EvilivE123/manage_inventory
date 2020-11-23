class ProductsController < ApplicationController
  before_action :get_details, only: :edit

  def index
    @products = Product.table.to_json
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  def get_details
    if params[:product_count].nil?
      @product = Product.find_by_sku_code(params[:sku_code])
      warehouse = (params[:wh_code].present? ? Warehouse.find_by_wh_code(params[:wh_code]) : nil)
      @inventory = Inventory.find_or_create_by(product: @product, warehouse: warehouse)
    else
      redirect_to root_path
    end  
  end
end
