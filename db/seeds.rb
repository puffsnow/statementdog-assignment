# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Labrador')
User.create(name: 'Shiba Inu')

Stock.create(name: '台積電', code: '2330')
Stock.create(name: '玉山金', code: '2884')
Stock.create(name: '長榮航', code: '2618')
