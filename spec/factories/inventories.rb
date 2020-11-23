FactoryBot.define do
  factory :inventory do
    warehouse
    product
    product_count { 12 }
  end
end