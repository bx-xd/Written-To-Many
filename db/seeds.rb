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
# ADDING MODIFICATIONS
# For adding modification, modify text with same name and in order of the lib/texts folder
# keep the naming convention form the original text
#
# 6 Créateurs
# 12 + Contributors
# 15 Users

puts "-> Reset database"
Post.destroy_all
Discussion.destroy_all
Modification.destroy_all
Text.destroy_all
Contributor.destroy_all
Project.destroy_all
User.destroy_all
puts "-> Reset database successfully"


puts "-> Start seeding"


puts "-> Create 15 Users"
def create_user(name)
  file = File.open("db/lib/images/#{name}.jpeg")
  name = User.new(username: "#{name}", email: "#{name}@email.com", password: 12345678)
  name.photo.attach(io: file, filename: "#{name}.jpeg", content_type: "image/jpeg")
  name.save!
  return name
end

john = create_user("john")
richard = create_user("richard")
paul = create_user("paul")
ringo = create_user("ringo")
george = create_user("george")
david = create_user("david")
roger = create_user("roger")
syd = create_user("syd")
siouxsie = create_user("siouxsie")
robert = create_user("robert")
katie = create_user("katie")
joanna = create_user("joanna")
sophie = create_user("sophie")
marine = create_user("marine")
louis = create_user("louis")
puts "-> You have now #{User.count} users"


puts "-> Create 6 Projects"
def create_project(project, user)
  file = File.open("db/lib/images/#{project}.jpeg")
  titlized_title = project.split("_").map(&:capitalize).join(' ')
  project = Project.new(title: titlized_title.to_s, description: "", user: user)
  project.photo.attach(io: file, filename: "#{project}.jpeg", content_type: "image/jpeg")
  project.save!
  return project
end

dialogue = create_project("dialogue_aux_enfers_entre_machiavel_et_montesquieu", louis)
pays_des_moines = create_project("au_pays_des_moines", george)
savant_russe = create_project("aventures_extraordinaires_d_un_savant_russe", marine)
effrayante = create_project("effreyante_aventure", paul)
jean_qui_pleure = create_project("jean_qui_grogne_jean_qui_rit", louis)
fort_sherlock = create_project("plus_fort_que_sherlock", joanna)
puts "-> You have now #{Project.count} projects"


puts "-> Create 20 Contributors"
def create_contributor(project, users)
  users.each do |user|
    contributor = Contributor.new(project: project, user: user)
    contributor.save!
  end
end
create_contributor(dialogue, [joanna, richard])
create_contributor(pays_des_moines, [louis, paul, katie])
create_contributor(savant_russe, [george, david, louis, sophie])
create_contributor(effrayante, [louis, syd, roger, siouxsie, robert])
create_contributor(jean_qui_pleure, [ringo, david, john])
create_contributor(fort_sherlock, [louis, marine, paul, syd])
puts "-> You have now #{Contributor.count} contributors"


puts "-> Create 6 Texts"
def create_text(project, text_file_name)
  file = File.open("db/lib/texts/#{text_file_name}.txt")
  result = file.read
  text = Text.new(project: project, content: result)
  text.save!
end

create_text(dialogue, "dialogue_aux_enfers_entre_machiavel_et_montesquieu")
create_text(pays_des_moines, "au_pays_des_moines")
create_text(savant_russe, "aventures_extraordinaires_d_un_savant_russe")
create_text(effrayante, "effreyante_aventure")
create_text(jean_qui_pleure, "jean_qui_grogne_jean_qui_rit")
create_text(fort_sherlock, "plus_fort_que_sherlock")
puts "-> You have now #{Text.count} texts"


puts "-> Create 8 Modifs"
def create_modification(text, user, modification_file_name, context)
  file = File.open("db/lib/texts/#{modification_file_name}.txt")
  result = file.read
  modification = Modification.new(text: text,
                                  user: user,
                                  content_before: text.content,
                                  content_after: result,
                                  status: "pending",
                                  context: context)
  modification.save!
  return modification
end

add_dialogue = create_modification(dialogue.text,
                                   joanna,
                                   "dialogue_aux_enfers_entre_machiavel_et_montesquieu1",
                                   "Ajout d'un dialogue de Machiavel")
delete_dialogue = create_modification(dialogue.text,
                                      richard,
                                      "dialogue_aux_enfers_entre_machiavel_et_montesquieu2",
                                      "suppression d'un passage de Montesquieu inexacte par rapport à sa philosophie")
add_intro = create_modification(dialogue.text,
                                richard,
                                "dialogue_aux_enfers_entre_machiavel_et_montesquieu3",
                                "Ajout d'une introduction sur les intentions du text")

following_story = create_modification(fort_sherlock.text,
                                      louis,
                                      "plus_fort_que_sherlock1",
                                      "Ajout de la partie 5")
add_mother_story = create_modification(fort_sherlock.text,
                                       paul,
                                       "plus_fort_que_sherlock2",
                                       "Ajout d'un paragraphe pour détailler la vie difficile de la jeune femme")
add_letter = create_modification(fort_sherlock.text,
                                 marine,
                                 "plus_fort_que_sherlock3",
                                 "Ajoute une lettre de l'enfant à sa mère pour appuyer les difficultés de l'enfant")
delete_story = create_modification(fort_sherlock.text,
                                   louis,
                                   "plus_fort_que_sherlock4",
                                   "Suppression d'une annecdote superflue sur l'enfant', perpétue l'intrigue")
add_intro_sherlock = create_modification(fort_sherlock.text,
                                         joanna,
                                         "plus_fort_que_sherlock5",
                                         "Ajout d'une introduction 'mystérieuse' sur le détéctive")
puts "-> You have now #{Modification.count} modifications."


puts "-> Create 11 Discussions"
def create_discussion(title, context = nil, project = nil, modification = nil)
  discussion = Discussion.new(title: title,
                              context: context,
                              modification: modification,
                              project: project)
  discussion.save!
  return discussion
end

dsc_historian = create_discussion("Attachement à la rigueur historique", dialogue)
dsc_philo = create_discussion("Moral philosophique du texte", dialogue)
dsc_add_dialogue = create_discussion("Ajout de dialogue de Machiavel", add_dialogue.context, dialogue)
dsc_delete_dialogue = create_discussion("Suppression d'un dialogue de Montesquieu", delete_dialogue.context, dialogue)
dsc_add_intro = create_discussion("Ajout d'une introduction", add_intro.context, dialogue)

dsc_parody = create_discussion("Limite de la parodie", fort_sherlock)
dsc_following_story = create_discussion("Partie 5", following_story.context, fort_sherlock)
dsc_add_mother_story = create_discussion("Annecdote sur la mère", add_mother_story.context, fort_sherlock)
dsc_add_letter = create_discussion("Ajout d'une lettre, partie 4", add_letter.context, fort_sherlock)
dsc_delete_story = create_discussion("Suppression d'une annecdote sur l'enfant", delete_story.context, fort_sherlock)
dsc_add_intro_sherlock = create_discussion("Ajout d'une intro sur le detective", add_intro_sherlock.context, fort_sherlock)
puts "-> You have now #{Discussion.count} discussions."


puts "-> Create Posts"
# 1 discussions où il y en a plein
# Pour le pitch, besoin d'une deuxieme conversation où il y en a beaucoup peut être moins
# Sur trois discussions, 4 posts max
puts "-> Finish to create Posts"

puts "-> End of seeding"
