class CreateWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouses do |t|
      t.string :wh_code, limit: 16
      t.string :name
      t.integer :pincode, limit: 6
      t.integer :max_capacity
      t.integer :threshold, default: 10

      t.timestamps
    end
    add_index :warehouses, :wh_code
  end
end
