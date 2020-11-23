class Inventory < ApplicationRecord

  # Associations
  belongs_to :product
  belongs_to :warehouse

  # Validations
  validates_numericality_of :product_count
  validate :exceeds_warehouse_max_capacity, if: [:warehouse_id?, :product_id?]

  def success_message
    "#{product_count} product('s) of '#{product.name}' are set for the warehouse in '#{warehouse.name}'"
  end
  # below will check whether upcoming inventory's product count exceeds the
  # warehouse max capacity
  def exceeds_warehouse_max_capacity
    changed_product_value = (self.product_count - self.product_count_was) rescue 0 
    total_product_count = changed_product_value + self.warehouse.item_count
    if total_product_count > self.warehouse.max_capacity
      errors.add(:base, "#{self.warehouse.name}'s warehouse max capacity reached!")
    end
  end

end
