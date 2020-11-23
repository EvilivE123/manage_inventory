class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku_code, limit: 8
      t.string :name
      t.integer :price

      t.timestamps
    end
    add_index :products, :sku_code
    add_index :products, :name
    add_index :products, :price
  end
end
