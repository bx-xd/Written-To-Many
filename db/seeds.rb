# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# ADDING USERS
# For adding user, store photo to attached in app/db/lib/images/username.jpeg
# Keep in mind that every files attached to user should match to his username
# Watch out to file extension: '.jpeg', not '.jpg'
#
# 6 Créateurs
# 12 + Contributors
# 15 Users

puts "-> Reset database"
# User.destroy_all
# Project.destroy_all
Contributor.destroy_all
Text.destroy_all
Modification.destroy_all
Discussion.destroy_all
Post.destroy_all
puts "-> Reset database successfully"

puts "-> Start seeding"

puts "-> Create 6 Users"
def create_user(name)
  file = File.open("db/lib/images/#{name}.jpeg")
  name = User.new(username: "#{name}", email: "#{name}@email.com", password: 12345678)
  name.photo.attach(io: file, filename: "#{name}.jpeg", content_type: "image/jpeg")
  name.save!
end

create_user("john")
create_user("richard")
create_user("paul")
create_user("ringo")
create_user("george")
create_user("david")
create_user("roger")
create_user("syd")
create_user("siouxsie")
create_user("robert")
create_user("katie")
create_user("joanna")
create_user("sophie")
create_user("marine")
create_user("louis")

puts "You have now #{User.count} projects"
puts "-> Finish to create 6 Users"

puts "-> Create 6 Projects"
def create_project(project, user)
  file = File.open("db/lib/images/#{project}.jpeg")
  titlized_title = project.split("_").map(&:capitalize).join(' ')
  project = Project.new(title: titlized_title.to_s, description: "", user: user)
  project.photo.attach(io: file, filename: "#{project}.jpeg", content_type: "image/jpeg")
  project.save!
end

create_project("dialogue_aux_enfers_entre_machiavel_et_montesquieu", User.find_by_username("louis"))
create_project("au_pays_des_moines", User.find_by_username("george"))
create_project("aventures_extraordinaires_d_un_savant_russe", User.find_by_username("marine"))
create_project("effreyante_aventure", User.find_by_username("paul"))
create_project("jean_qui_grogne_jean_qui_rit", User.find_by_username("louis"))
create_project("plus_fort_que_sherlock", User.find_by_username("joanna"))

puts "You have now #{Project.count} projects"
puts "-> Finish to create 6 Projects"

puts "-> Create 10 Contributors"
contributors_to_dialogue = []
Contributor.new(project: )
puts "-> Finish to create 10 Contributors"
# 12 Contributeurs

puts "-> Create 6 Texts"
# file = File.open("textpath")
# result = file.read
# text = Text.new(project: Project.find, content: result)
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
