# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Money::Currency.all.each do |currency|
    Currency.create(iso_code: currency.iso_code)
end

# User.create(name: 'saad', email: 'saadfazil123@gmail.com', role: 3, encrypted_password: '123123')

user = User.new
user.email = 'test@example.com'
user.name = 'saad'
user.role = 3
user.password = '41&tbJdvY7DE'
user.password_confirmation = '41&tbJdvY7DE'
user.save!
