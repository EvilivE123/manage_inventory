class InventoriesController < ApplicationController
  def update
    inventory = Inventory.find(params[:id])
    inventory.update_attributes(inventory_param)
    respond_to do |format|
      if inventory.valid? 
        flash[:notice] = inventory.success_message
      else
        flash[:danger] = inventory.errors.full_messages.to_sentence
      end
      format.html { redirect_to root_path }
    end
  end

  private

  def inventory_param
    params.require(:inventory).permit(:product_count)
  end
end
