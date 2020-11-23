class WarehousesController < ApplicationController
  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    respond_to do |format|
      if @warehouse.valid?
        @warehouse.save
        format.html { redirect_to products_path, success: 'Warehouse created' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :pincode, :max_capacity)
  end
end
