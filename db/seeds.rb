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
  name = User.new(username: "#{name}", email: "#{name}@email.com", password: "12345678")
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
puts "-> #{User.count} Users have been created."


puts "-> Create 6 Projects"
def create_project(project, user, created_at)
  file = File.open("db/lib/images/#{project}.jpeg")
  titlized_title = project.split("_").map(&:capitalize).join(' ')
  project = Project.new(title: titlized_title.to_s, description: "", user: user, created_at: created_at)
  project.photo.attach(io: file, filename: "#{project}.jpeg", content_type: "image/jpeg")
  project.save!
  return project
end

dialogue = create_project("dialogue_aux_enfers_entre_machiavel_et_montesquieu", louis, DateTime.new(2021, 10, 28, 11, 32, 53))
pays_des_moines = create_project("au_pays_des_moines", george, DateTime.new(2021, 11, 3, 13, 58, 11))
savant_russe = create_project("aventures_extraordinaires_d_un_savant_russe", marine, DateTime.new(2021, 11, 15, 21, 22, 48))
effrayante = create_project("effraeyante_aventure", paul, DateTime.new(2021, 11, 10, 16, 15, 42))
jean_qui_pleure = create_project("jean_qui_grogne_jean_qui_rit", louis, DateTime.new(2021, 8, 18, 12, 2, 19))
fort_sherlock = create_project("plus_fort_que_sherlock", joanna, DateTime.new(2021, 9, 28, 9, 45, 11))
fort_sherlock.update(description: "Je vous propose d'écrire une parodie de Sherlock Holmes à plusieurs")
puts "-> #{Project.count} Projects have been created."


puts "-> Create 21 Contributors"
def create_contributor(project, users, date)
  users.each do |user|
    contributor = Contributor.new(project: project, user: user)
    contributor.save!
    contributor.update(created_at: date, updated_at: date)
    date += 1.minute
  end
end
create_contributor(dialogue, [joanna, richard], DateTime.new(2021, 10, 28, 19, 21, 1))
create_contributor(pays_des_moines, [louis, paul, katie], DateTime.new(2021, 11, 3, 14, 15, 30))
create_contributor(savant_russe, [george, david, louis, sophie], DateTime.new(2021, 11, 15, 21, 30, 33))
create_contributor(effrayante, [louis, syd, roger, siouxsie, robert], DateTime.new(2021, 11, 11, 9, 10, 4))
create_contributor(jean_qui_pleure, [ringo, david, john], DateTime.new(2021, 8, 18, 14, 25, 7))
create_contributor(fort_sherlock, [louis, marine, paul, syd], DateTime.new(2021, 9, 28, 15, 11, 29))
puts "-> #{Contributor.count} contributors have been created."


puts "-> Create 6 Texts"
def create_text(project, text_file_name, extension)
  file = File.open("db/lib/texts/#{text_file_name}#{extension}")
  result = file.read
  text = Text.new(project: project, content: result, created_at: project.created_at)
  text.save!
end

create_text(dialogue, "dialogue_aux_enfers_entre_machiavel_et_montesquieu", ".txt")
create_text(pays_des_moines, "au_pays_des_moines", ".txt")
create_text(savant_russe, "aventures_extraordinaires_d_un_savant_russe", ".txt")
create_text(effrayante, "effrayante_aventure", ".txt")
create_text(jean_qui_pleure, "jean_qui_grogne_jean_qui_rit", ".txt")
create_text(fort_sherlock, "plus_fort_que_sherlock", ".json")
puts "-> #{Text.count} texts have been created."


puts "-> Create 18 Modifs"
def create_modification(text, user, status, title, context, created_at, modification_file_name = nil)
  if modification_file_name
    file = File.open("db/lib/texts/#{modification_file_name}.txt")
    result = file.read
  end
  modification = Modification.new(text: text,
                                  user: user,
                                  content_before: text.content,
                                  content_after: result ? result : "text.content",
                                  status: status,
                                  title: title,
                                  context: context,
                                  created_at: created_at)
  modification.save!
  modification.update(updated_at: created_at)

  return modification
end

def create_json_modification(text, user, status, title, context, created_at, modification_file_name = nil)
  file = File.open("db/lib/texts/plus_fort_que_sherlock_#{modification_file_name}_content_before.json")
  content_before = file.read
  file = File.open("db/lib/texts/plus_fort_que_sherlock_#{modification_file_name}_content_after.json")
  content_after = file.read

  modification = Modification.new(text: text,
                                  user: user,
                                  content_before: content_before,
                                  content_after: content_after,
                                  status: status,
                                  title: title,
                                  context: context,
                                  created_at: created_at)
  modification.save!

  diff = JSON.parse(modification.content_after)["blocks"] - JSON.parse(modification.content_before)["blocks"]
  data = JSON.parse(modification.content_after)

  diff.each do |modif_block|
    block = data["blocks"].find { |block| block["id"] == modif_block["id"] }
    block["data"]["class"] = "custom-modification"
    block["data"]["id"] = modification.id
  end

  modification.content_after = data.to_json
  modification.save!
  modification.update(updated_at: created_at)

  return modification
end

modif_1 = create_modification(pays_des_moines.text, paul, "pending", "Partie 4", "Ajout de la partie 4", DateTime.new(2021, 11, 24, 13, 52, 3))
modif_2 = create_modification(pays_des_moines.text, george, "pending", "Description du monastère", "Ajout de descriptions du monastère", DateTime.new(2021, 11, 15, 1, 32, 6))
modif_3 = create_modification(pays_des_moines.text, louis, "pending", "Liaison partie 2 et 3", "Reprise de la liaison entre les parties 2 et 3", DateTime.new(2021, 11, 28, 18, 46, 21))
modif_4 = create_modification(savant_russe.text, david, "pending", "La mort de Raspoutine", "Explication de la mort de Raspoutine", DateTime.new(2021, 11, 20, 15, 37, 7))
modif_5 = create_modification(savant_russe.text, sophie, "pending", "Dénouement de l'arc sur le voyage du savant", "Ajout de la fin de l'arc sur le voyage du savant", DateTime.new(2021, 11, 23, 13, 26, 39))
modif_6 = create_modification(effrayante.text, syd, "pending", "Suite et fin du personnage de Josie", "Ajout de la fin de la description de Josie", DateTime.new(2021, 11, 12, 11, 18, 32))
modif_7 = create_modification(effrayante.text, siouxsie, "pending", "Partie 3", "Ajout de la partie 3", DateTime.new(2021, 11, 11, 10, 10, 1))
modif_8 = create_modification(effrayante.text, louis, "pending", "Suppression de la conclusion partie 2", "Je ne trouve pas la partie 2 interessante, déso", DateTime.new(2021, 11, 12, 17, 15, 11))
modif_9 = create_modification(effrayante.text, paul, "pending", "Introduction du personnage de Tom", "Description de Tom", DateTime.new(2021, 11, 13, 17, 9, 8))
modif_10 = create_modification(jean_qui_pleure.text, ringo, "pending", "Titres des parties", "Modification des titres", DateTime.new(2021, 8, 20, 14, 19, 22))
modif_11 = create_modification(jean_qui_pleure.text, david, "pending", "Description de la maison de campagne", "Bienvenue à la campagne, dans les champs avec un belle chaumière", DateTime.new(2021, 8, 19, 20, 36, 44))
modif_12 = create_modification(jean_qui_pleure.text, john, "pending", "Passage dans la cours d'école - Chapitre 3", "Ajout dans le chapitre 3 d'une histoire dans la cours d'école", DateTime.new(2021, 8, 21, 22, 49, 11))
add_dialogue = create_modification(dialogue.text,
                                   joanna,
                                   "pending",
                                   "Dialogue de Machiavel",
                                   "Ajout d'un dialogue de Machiavel",
                                   DateTime.new(2021, 11, 29, 11, 42, 56),
                                   "dialogue_aux_enfers_entre_machiavel_et_montesquieu1")
delete_dialogue = create_modification(dialogue.text,
                                    richard,
                                    "accepted",
                                    "Suppression d'un passage",
                                    "suppression d'un passage de Montesquieu inexacte par rapport à sa philosophie",
                                    DateTime.new(2021, 11, 27, 20, 15, 6),
                                    "dialogue_aux_enfers_entre_machiavel_et_montesquieu2")
add_intro = create_modification(dialogue.text,
                                richard,
                                "denied",
                                "Intro du texte",
                                "Ajout d'une introduction sur les intentions du texte",
                                DateTime.new(2021, 11, 25, 9, 16, 49),
                                "dialogue_aux_enfers_entre_machiavel_et_montesquieu3")


following_story = create_json_modification(fort_sherlock.text,
                                            paul,
                                            "pending",
                                            "Ajout de l'introduction",
                                            "J'ai écrit l'introduction",
                                            DateTime.new(2021, 11, 25, 20, 34, 11),
                                            "1")
add_mother_story = create_json_modification(fort_sherlock.text,
                                            louis,
                                            "pending",
                                            "Détail de la vie de la jeune femme",
                                            "Ajout d'un paragraphe pour détailler la vie difficile de la jeune femme",
                                            DateTime.new(2021, 11, 24, 22, 15, 37),
                                            "2")
add_letter = create_json_modification(fort_sherlock.text,
                                      marine,
                                      "pending",
                                      "Lettre de l'enfant à sa mère",
                                      "Ajoute une lettre de l'enfant à sa mère pour appuyer les difficultés de l'enfant",
                                      DateTime.new(2021, 11, 27, 13, 35, 44),
                                      "3")

add_detectiv_desc = create_json_modification(fort_sherlock.text,
                                      syd,
                                      "pending",
                                      "Ajout d'une description du detective",
                                      "Voici un proposition de description du détective, un peu osée mais je pense que ça correspond bien pour cette parodie",
                                      DateTime.new(2021, 11, 22, 22, 23, 24),
                                      "3")


# delete_story = create_json_modification(fort_sherlock.text,
#                                         louis,
#                                         "plus_fort_que_sherlock4",
#                                         "pending",
#                                         "Suppression d'une annecdote superflue sur l'enfant', perpétue l'intrigue",
#                                         Date.new(2021, 11, 22))
# add_intro_sherlock = create_json_modification(fort_sherlock.text,
#                                               joanna,
#                                               "plus_fort_que_sherlock5",
#                                               "accepted",
#                                               "Ajout d'une introduction 'mystérieuse' sur le détéctive",
#                                               Date.new(2021, 11, 19))
puts "-> #{Modification.count} modifications have been created."


puts "-> Create 20 Discussions"
def create_discussion(title, context, project, modification = nil)
  discussion = Discussion.new(title: title,
                              context: context,
                              modification: modification,
                              project: project,
                              created_at: modification ? modification.created_at : project.created_at)
  discussion.save!
  modification ? discussion.update(updated_at: modification.updated_at) : discussion.update(updated_at: project.updated_at)
  return discussion
end

# create_discussion(title, context, project, modification = nil)
disc_1 = create_discussion(modif_1.title, modif_1.context, modif_1.text.project, modif_1)
disc_2 = create_discussion(modif_2.title, modif_2.context, modif_2.text.project, modif_2)
disc_3 = create_discussion(modif_3.title, modif_3.context, modif_3.text.project, modif_3)
disc_4 = create_discussion(modif_4.title, modif_4.context, modif_4.text.project, modif_4)
disc_5 = create_discussion(modif_5.title, modif_5.context, modif_5.text.project, modif_5)
disc_6 = create_discussion(modif_6.title, modif_6.context, modif_6.text.project, modif_6)
disc_7 = create_discussion(modif_7.title, modif_7.context, modif_7.text.project, modif_7)
disc_8 = create_discussion(modif_8.title, modif_8.context, modif_8.text.project, modif_8)
disc_9 = create_discussion(modif_9.title, modif_9.context, modif_9.text.project, modif_9)
disc_10 = create_discussion(modif_10.title, modif_10.context, modif_10.text.project, modif_10)
disc_11 = create_discussion(modif_11.title, modif_11.context, modif_11.text.project, modif_11)
disc_12 = create_discussion(modif_12.title, modif_12.context, modif_12.text.project, modif_12)

create_discussion(add_dialogue.title, add_dialogue.context, add_dialogue.text.project, add_dialogue)
dsc_delete_dialogue = create_discussion(delete_dialogue.title, delete_dialogue.context, delete_dialogue.text.project, delete_dialogue)
create_discussion(add_intro.title, add_intro.context, add_intro.text.project, add_intro)
# create_discussion("Attachement à la rigueur historique", nil, dialogue)
# create_discussion("Moral philosophique du texte", nil, dialogue)
# create_discussion("Ajout de dialogue de Machiavel", add_dialogue.context, dialogue, add_dialogue)
# dsc_delete_dialogue = create_discussion("Suppression d'un dialogue de Montesquieu", delete_dialogue.context, dialogue, delete_dialogue)
# create_discussion("Ajout d'une introduction", add_intro.context, dialogue, add_intro)

general_disc = create_discussion("Limite de la parodie", "Je trouve que la parodie a ses limites, où s'arreter ?", fort_sherlock) # disc générale fort_sherlock
general_disc.update(updated_at: general_disc.created_at)

dsc_following_story = create_discussion(following_story.title, following_story.context, following_story.text.project, following_story)
dsc_add_mother_story = create_discussion(add_mother_story.title, add_mother_story.context, add_mother_story.text.project, add_mother_story)
dsc_add_letter = create_discussion(add_letter.title, add_letter.context, add_letter.text.project, add_letter)
dsc_add_detectiv_desc = create_discussion(add_detectiv_desc.title, add_detectiv_desc.context, add_detectiv_desc.text.project, add_detectiv_desc)
# dsc_following_story = create_discussion("Partie 5", following_story.title, fort_sherlock, following_story)
# dsc_add_mother_story = create_discussion("Annecdote sur la mère", add_mother_story.title, fort_sherlock, add_mother_story)
# dsc_add_letter = create_discussion("Ajout d'une lettre, partie 3", add_letter.title, fort_sherlock, add_letter)
puts "-> #{Discussion.count} discussions have been created."


puts "-> Create Posts"
def create_post(user, discussion, text, created_at)
  post = Post.new(user: user, discussion: discussion, text: text, created_at: created_at)
  post.save!
  post.update(updated_at: created_at)
  return post
end

create_post(richard, dsc_delete_dialogue,
            "Je me suis permis de supprimer le passage de Montesquieu qui se présente à Machiavel,
            En effet ce passage me parait peu rigoureux historiquement parlant, Montesquieu se présente
            comme un ministre de Louis XVI ce qu'il n'était pas. De plus les locutions pour se dire bonjour ne
            correspondent pas, vers 1750, date du décès de celui-ci, dans ce dialogue le 'bon' et le 'jour' sont
            séparés alors que cette façon d'écrire correspond plus à une tradition littéraire du XIIIeme siècle.
            De manière général j'ai supprimé l'ensemble du passage pour qu'il soit retravailler du fait qu'il ne
            convenait pas à la rigueur qu'on s'est fixé au préalable sur le texte mais aussi car il rompt avec
            le sens logique des personnages historiques.",
            DateTime.new(2021, 11, 27, 20, 24, 56))
create_post(louis, dsc_delete_dialogue,
            "Je te rejoins sur la rigueur des locutions, pour le coup elles sont ici vraiment annachroniques
            et difficile à lire de manière général, de la même manière qu'il se présente en tant que ministre
            pose un soucis de cohérence historique pas compliqué à verifier.
            Par contre je trouve la suppression totale du passage trop sévère. Ce dernier avait l'avantage d'éclairer
            correctement la philosophie de Montesquieu et de l'introduire correctement. J'aimerai aussi rajouter que
            on est ici dans un genre proche du postiche, malgré notre volonté de faux écrits, par conséquent
            je pense qu'on ne doit pas non plus exercer trop de pression pour suivre une forme de rigueur dans nos
            dialogues.
            Il faut trouver le bon compromis.",
            DateTime.new(2021, 11, 30, 9, 22, 35))
create_post(joanna, dsc_delete_dialogue,
            "Je vous rejoins, même si j'avais écris ce passage ça me va de le supprimer, de toute façon
            il aurait été trop pénible à reprendre pour le réintégrer. A la limite on pourra réintroduire
            la philosophie de Montesquieu plus en aval du texte, je pense que ce qui compte c'est qu'on
            comprenne les valeurs morales de Machiavel avant de les confronter à la philosophie de
            Montesquieu.",
            DateTime.new(2021, 11, 30, 11, 59, 22))
# Modification accépté
create_post(louis, dsc_add_mother_story,
            "Je me suis permis de rajouter ce passage, je trouvais que ça nous permettait de passer
            à la suite de façon moins abrupte",
            DateTime.new(2021, 11, 24, 22, 34, 37))
create_post(syd, dsc_add_mother_story,
            "Je suis pas du tout d'accord, je trouve justement que le passage à la suite nous permettait
            d'en déduire ou d'imaginer pleins de choses par rapport à ce qui lui était arrivé.",
            DateTime.new(2021, 11, 25, 11, 12, 13))
create_post(joanna, dsc_add_mother_story,
            "Je rejoins Syd là-dessus, je trouve que ça rallonge le texte pour rien, je suis par contre ouverte
            à ce que l'ensemble de la partie qui introduit la mère soit plus longue et peut être plus étoffée
            mais pas sur cette fin de partie.",
            DateTime.new(2021, 11, 25, 13, 46, 34))
create_post(louis, dsc_add_mother_story,
            "Je peux aussi retravailler le passage pour y ajouter du suspens, j'aime quand même bien l'idée qu'on
            explicite mieux le background des personnages et qu'on laisse des non-dits plus loins dans le récit.",
            DateTime.new(2021, 11, 26, 21, 35, 44))
create_post(paul, dsc_add_mother_story,
            "Je rejoins les autres, le problème c'est que tu casses l'effet avec ce passage, je vois difficilement
            comment tu pourrais rattraper ça puisque c'est pas tellement le contenu le problème mais son placement",
            DateTime.new(2021, 11, 30, 12, 2, 7))
create_post(joanna, dsc_add_mother_story,
            "Si tout le monde est d'accord je me permets de refuser ce passage.",
            DateTime.new(2021, 12, 2, 14, 22, 48))
# Modification refusé
create_post(paul, dsc_following_story,
            "J'ouvre la discussion autour de cette nouvelle partie que je viens d'ajouter",
            DateTime.new(2021, 11, 25, 20, 36, 45))
create_post(louis, dsc_following_story,
            "J'aime beaucoup le suspense laissé à la fin et en même temps l'arrivée du détéctive",
            DateTime.new(2021, 11, 25, 21, 11, 46))
create_post(joanna, dsc_following_story,
            "Par contre il faut qu'on se pose la question vis à vis de la parodie, par ce que là c'est
            très bien écrit mais on dirait du pure Conan Doyle, j'ai du mal à voir le pastiche ici.",
            DateTime.new(2021, 11, 26, 11, 34, 13))
create_post(marine, dsc_following_story,
            "Je rejoins Joanna néanmoins on peut nuancer, cette super introduction du détéctive ira parfaitement
            en contrepoint de la parodie du personnage qui viendra plus tard dans le texte. Je pense c'est important
            de pas non plus s'acharner sur ce personnage, on souhaite le parodier, pas le tourner complétement en ridicule,
            c'est bien par ce qu'on apprécie tous Sherlock qu'on est ici à vouloir le parodier.
            Dans tous les cas je suis hyper contente de lire ce passage sur son introduction, bravo Paul.",
            DateTime.new(2021, 11, 27, 16, 12, 13))
create_post(joanna, dsc_following_story,
            "Merci Marine, en effet j'avais prévu dans la suite du texte de venir introduire un contrepoint, notamment
            au moment où il est utilisé dans le cadre de son enquête, ses dons d'observations. J'avais pensés à tout un passage
            très déscriptif où ces dons permettent de résoudre une histoire très anciennes, des fermiers chez qui il est sans pour
            autant résoudre l'affaire en court.
            A mon sens c'est une manière pour nous aussi de continuer à rendre hommage tout en s'adonnant à une gentille parodie.",
            DateTime.new(2021, 11, 28, 8, 12, 49))
create_post(syd, dsc_following_story,
            "Attention à ne pas rejouer la discussion du channel général, je suis d'accord, il faut un minimum
            introduire notre volonté de parodier Holmes si on ne veut pas créer un décalage de ton
            au moment où on souhaitera le parodier franchement.
            Pour le moment lorsqu'on relit le texte on a du mal à discerner l'humour ou la parodie qui pourra intervenir,
            c'est même franchement un texte plutôt triste.
            A mon avis, soit on retouche cette modification, soit on ajoute plus en amont du texte, des éléments, qui appellent
            à l'humour qu'on souhaitera utiliser plus tard.",
            DateTime.new(2021, 11, 29, 18, 46, 32))
create_post(joanna, dsc_add_detectiv_desc,
            "Désolée de le dire d'une manière si brutale mais le plagiat n'est pas toléré ici non plus Syd !
             Je sais que c'était une blague mais je ne veux pas encourager les mauvais comportements.",
            DateTime.new(2021, 11, 23, 8, 32, 11))
puts "-> #{Post.count} posts have been created."


# Accept / deny modif

add_detectiv_desc.update(status: "denied", updated_at: DateTime.new(2021, 11, 23, 8, 35, 22))

add_letter.update(status: "accepted", updated_at: DateTime.new(2021, 11, 27, 20, 10, 4))

puts "-> End of seeding"
