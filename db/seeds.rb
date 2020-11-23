# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



cities = ['Mumbai', 'New Delhi', 'Bangalore']
# Creating Warehouses.
cities.each do |name| 
  warehouse = Warehouse.new(
    name: name, 
    pincode: rand(100000..999999), 
    max_capacity: rand(800..1000)
  )
  warehouse.save
  if warehouse.persisted?
    puts "Warehouse with wh_code '#{warehouse.wh_code}' is saved into the database."
  else
    puts "Faced Errors => #{warehouse.errors.full_messages.to_sentence}"
  end
end

# Creating products and adding it to the warehouse through inventory.
60.times do |index|
  puts "\n\n"
  product = Product.new(
    name: "#{Faker::Food.spice}", 
    price: rand(10..100)
  )
  product.save
  if product.persisted?
    puts "Product with sku_code '#{product.sku_code}' is saved into the database."
  else
    puts "Faced Errors => #{product.errors.full_messages.to_sentence}"
  end
  puts "\n"
  cities.each do |city_name|
    warehouse = Warehouse.find_by_name(city_name)
    inventory = product.inventories.new(warehouse: warehouse)
    case city_name
    when 'Mumbai'
      inventory.product_count = rand(10..15)
    when 'New Delhi'
      inventory.product_count = ((index < 20) ? rand(5..9) : rand(10..15))
    when 'Bangalore'
      inventory.product_count = ((index < 30) ? rand(5..9) : rand(10..15))
    end
    inventory.save
    if inventory.persisted?
      puts "Inventory for city '#{city_name}' and product '#{product.name}' is saved into database."
    else
      puts "Faced Errors => #{inventory.errors.full_messages.to_sentence}"
    end
  end
end
