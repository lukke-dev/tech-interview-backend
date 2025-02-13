# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Product.create([
  {
    name: 'Samsung Galaxy S24 Ultra',
    price: 12999.99
  },
  {
    name: 'iPhone 15 Pro Max',
    price: 14999.99
  },
  {
    name: 'Xiamo Mi 27 Pro Plus Master Ultra',
    price: 999.99
  },
  {
    name: 'PlayStation®5 Slim Edição Digital',
    price: 3292.10
  },
  {
    name: 'Placa de Vídeo RTX 4070 Super Gigabyte',
    price: 4899.99
  },
  {
    name: 'Notebook ASUS VivoBook Go 15',
    price: 2507.12
  },
  {
    name: 'Apple notebook MacBook Air',
    price: 6999.99
  }
])
