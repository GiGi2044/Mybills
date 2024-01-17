# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Plan.delete_all

# Create plan records
Plan.create(title: 'Free', content: 'Up to 5 bills per month', price: 0)
Plan.create(title: 'Standard', content: 'Up to 25 bills per month', price: 5)
Plan.create(title: 'Premium', content: 'Unlimited bills per month', price: 15)

puts "Created #{Plan.count} plans."
