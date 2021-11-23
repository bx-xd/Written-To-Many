# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "-> Reset database"

User.destroy_all
Project.destroy_all
Contributor.destroy_all
Text.destroy_all
Modification.destroy_all
Discussion.destroy_all
Post.destroy_all

puts "-> Reset database successfully"


puts "-> Start seeding"

puts "-> Create 6 Users"
# 6 Créateurs
# 12 + contributeurs
# 18 MAX user
puts "-> Finish to create 6 Users"

puts "-> Create 6 Projects"
puts "-> Finish to create 6 Projects"

puts "-> Create 10 Contributors"
# 12 Contributeurs
puts "-> Finish to create 10 Contributors"

puts "-> Create 6 Texts"
puts "-> Finish to create 6 Texts"

puts "-> Create 8 Modifs"
# 4 modiffication on 2 texts
# One text that you create
# One that you follow as contributor
puts "-> Finish to create 8 Modifs"

puts "-> Create 11 Discussions"
# 8 Dissussion for 8 modifications
# Then 3 more for general discuss7
# 1 Discussion sur une modif ouverte
# 1 Discussion sur une modif fermé
puts "-> Finish to create 11 Discussions"

puts "-> Create Posts"
# 1 discussions où il y en a plein
# Pour le pitch, besoin d'une deuxieme conversation où il y en a beaucoup peut être moins
# Sur trois discussions, 4 posts max
puts "-> Finish to create Posts"

puts "-> End of seeding"
