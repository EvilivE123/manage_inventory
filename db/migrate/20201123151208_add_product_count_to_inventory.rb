class AddProductCountToInventory < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :product_count, :integer, default: 0
  end
end
