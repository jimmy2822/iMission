# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "JimmyWu", email: "jimmy2822@gmail.com", password: "123")

Tag.create(name: "game")
Tag.create(name: "web")
Tag.create(name: "coding")
