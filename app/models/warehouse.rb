class Warehouse < ApplicationRecord

  # Associations
  has_many :inventories
  has_many :products, through: :inventories

  # Validations
  validates_presence_of :wh_code, :name, :pincode, :max_capacity
  validates :wh_code, length: { in: 4..16 }
  validates :pincode, length: { is: 6 }
  validates_numericality_of :max_capacity, :pincode

  # Callbacks
  before_validation(on: :create) do
    self.wh_code = SecureRandom.hex(8)
  end

  # Instance Methods

  # below will return the item count of the warehouse
  def item_count
    inventories.map(&:product_count).sum
  end
end
