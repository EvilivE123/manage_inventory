class Product < ApplicationRecord
  # Associations
  has_many :inventories, dependent: :destroy
  has_many :warehouses, through: :inventories

  # Validations
  validates :sku_code, length: { is: 8 }
  validates_presence_of :name
  validates :price, presence: true, numericality: true

  before_validation(on: :create) do
    self.sku_code = SecureRandom.hex(4)
  end

  def self.table_header_names
    ['Sku-Code', 'Name'] + Warehouse.pluck(:name)
  end

  def self.table
    details = []
    product_data = {}
    column_names = []
    Product.all.each do |product|
      product_data = {
        "sku_code": product.sku_code,
        "name": product.name, 
      }
      Warehouse.all.each_with_index do |warehouse, index|
        product_data.merge!({
          "item_count_#{index}": (product.inventories.find_by_warehouse_id(warehouse.id).product_count rescue 0)
        })
      end
      details << product_data  
    end
    details.first.keys.each do |key|
      column_names << { data: key.to_s }
    end
    { details: details, column_names: column_names }
  end

  def to_param
    sku_code
  end
end
