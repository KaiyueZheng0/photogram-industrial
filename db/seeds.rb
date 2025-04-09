# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Ensure existence of example users
User.find_or_create_by!(email: "alice@example.com") do |user|
  user.username = "alice"
  user.password = "password"
end

User.find_or_create_by!(email: "bob@example.com") do |user|
  user.username = "bob"
  user.password = "password"
end
