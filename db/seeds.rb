# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: "andy.brogan.bayer@gmail.com", password: "Password12345", firstname: "Andy", lastname: "Bayer", phone: "(260)-449-1295", skill_level: 6, is_admin: true, emergency_contact_name: "Chelsea Blanchard", emergency_contact_phone: "(260)-710-3848", verified: true)
