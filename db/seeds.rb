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
puts "-> #{User.count} Users have been created."


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
puts "-> #{Project.count} Projects have been created."


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
puts "-> #{Contributor.count} contributors have been created."


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
puts "-> #{Text.count} texts have been created."


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
puts "-> #{Modification.count} modifications have been created."


puts "-> Create 11 Discussions"
def create_discussion(title, context = nil, project = nil, modification = nil)
  discussion = Discussion.new(title: title,
                              context: context,
                              modification: modification,
                              project: project)
  discussion.save!
  return discussion
end

dsc_historian = create_discussion("Attachement à la rigueur historique", nil, dialogue)
dsc_philo = create_discussion("Moral philosophique du texte", nil, dialogue)
dsc_add_dialogue = create_discussion("Ajout de dialogue de Machiavel", add_dialogue.context, dialogue, add_dialogue)
dsc_delete_dialogue = create_discussion("Suppression d'un dialogue de Montesquieu", delete_dialogue.context, dialogue, delete_dialogue)
dsc_add_intro = create_discussion("Ajout d'une introduction", add_intro.context, dialogue, add_intro)

dsc_parody = create_discussion("Limite de la parodie", nil, fort_sherlock)
dsc_following_story = create_discussion("Partie 5", following_story.context, fort_sherlock, following_story)
dsc_following_story_bebor = create_discussion("Parti 2, 3, 4", following_story.context, fort_sherlock, following_story)
dsc_add_mother_story = create_discussion("Annecdote sur la mère", add_mother_story.context, fort_sherlock, add_mother_story)
dsc_add_letter = create_discussion("Ajout d'une lettre, partie 4", add_letter.context, fort_sherlock, add_letter)
dsc_delete_story = create_discussion("Suppression d'une annecdote sur l'enfant", delete_story.context, fort_sherlock, delete_story)
dsc_add_intro_sherlock = create_discussion("Ajout d'une intro sur le detective", add_intro_sherlock.context, fort_sherlock, add_intro_sherlock)
puts "-> #{Discussion.count} discussions have been created."


puts "-> Create Posts"
def create_post(user, discussion, text)
  post = Post.new(user: user, discussion: discussion, text: text)
  post.save!
end

create_post(richard, dsc_delete_dialogue,
            "Je me suis permis de supprimé le passage de Montesquieu qui se présente à Machiavel,
            En effet ce passage me parait peu rigoureux historiquement parlant, Montesquieu se présente
            comme un ministre de Louis XVI ce qu'il n'était pas. De plus les locutions pour se dire bonjour ne
            correspondent pas, vers 1750, date du décès de celui-ci, dans ce dialogue le 'bon' et le 'jour' sont
            séparés alors que cette façon d'écrire correspond plus à une tradition littéraire du XIIIeme siècle.
            De manière général j'ai supprimé l'ensemble du passage pour qu'il soit travailler du fait qu'il ne
            convenait pas à la rigueur qu'on s'est fixé au préalable sur le texte mais aussi car il rompt avec
            le sens logique des personnages historiques.")
create_post(louis, dsc_delete_dialogue,
            "Je te rejoins sur la rigueur des locutions, pour le coup elles sont ici vraiment annachroniques
            et difficile à lire de manière général, de la même manière qu'il se présente en tant que ministre
            pose un soucis de cohérence historique pas compliqué à verifier.
            Par contre je trouve la suppression totale du passage trop sévère. Ce dernier avant l'avantage d'éclairer
            correctement la philosophie de Montesquieu et de l'introduire correctement. J'aimerai aussi rajouter que
            on est ici dans un genre proche du postiche, malgré notre volonté de faux écrits, par conséquent
            je pense qu'on ne doit pas non plus exercer trop de pression pour suivre une forme de rigueur dans nos
            dialogues.
            Il faut trouver le bon compromis.")
create_post(joanna, dsc_delete_dialogue,
            "Je vous rejoins, même si j'avais écris ce passage ça me va de le supprimer, de toute façon
            il aurait été trop pénible à reprendre pour le réintégrer. A la limite on pourra réintroduire
            la philosophie de Montesquieu plus en aval du texte, je pense que ce qui compte c'est qu'on
            comprenne les valeurs morales de Machiavel avant de les confronter à la philosophie de
            Montesquieu.")
# Modification accépté
create_post(louis, dsc_add_mother_story,
            "Je me suis permis de rajouter ce passage, je trouver que ça nous permettait de passer
            à la suite de façon moins abrupt")
create_post(syd, dsc_add_mother_story,
            "Je suis pas du tout d'accord, je trouver justement que le passage à la suite nous permettait
            d'en déduire ou d'imaginer pleins de choses par rapport à ce qui lui été arriver.")
create_post(joanna, dsc_add_mother_story,
            "Je rejoins Syd là dessus, je trouve que ça rallonge le texte pour rien, je suis par contre ouverte
            à ce que l'ensemble de la partie qui introduit la mère soit plus longue et peut être plus étoffé
            mais pas sur cette fin de partie.")
create_post(louis, dsc_add_mother_story,
            "Je peux aussi retravailler le passage pour y ajouter du suspens, j'aimer bien l'idée quand même qu'on
            explicite mieux le background des personnages et qu'on laisse des non-dits plus loins dans le récit.")
create_post(paul, dsc_add_mother_story,
            "Je rejoins les autres, le problème c'est que tu casses l'effet avec ce passage, je vois difficilement
            comment tu pourrais rattraper ça puisque c'est pas tellement le contenu le problème mais son placement")
create_post(joanna, dsc_add_mother_story,
            "Si tout le monde est d'accord je me permets de refuser ce passage.")
# Modification refusé
create_post(joanna, dsc_following_story,
            "J'ouvre la discussion autour de cette nouvelle partie que je viens d'ajouter")
create_post(louis, dsc_following_story,
            "J'aime beaucoup le suspence laisser à la fin et en même temps l'arriver du détéctive")
create_post(paul, dsc_following_story,
            "Par contre il faut qu'on se pose la question vis à vis de la parodie, par ce que là c'est
            très bien écrit mais on dirait du pure Conan Doyle, j'ai du mal à voir le pastiche ici.")
create_post(marine, dsc_following_story,
            "Je rejoins Paul néanmoins on peut nuancer, cette super introduction du détéctive ira parfaitement
            en contrepoint de la parodie du personnage qui viendra plus tard dans le texte. Je pense c'est important
            de pas non plus s'acharner sur ce personnage, on souhaite le parodier, pas le tourner complétement en ridicule,
            c'est bien par ce qu'on apprécie tous Sherlock qu'on est ici à vouloir le parodier.
            Dans tous les cas je suis hyper contente de lire ce passage sur son introduction, bravo joanna.")
create_post(joanna, dsc_following_story,
            "Merci Marine, en effet j'avais prévu dans la suite du texte de venir introduire un contrepoint, notamment
            au moment où il est utilisé dans le cadre de son enquête, ses dons d'observations. J'avais pensés à tout un passage
            très déscriptif où ces dons permettent de résoudre une histoire très anciennes des fermiers chez qui il est sans pour
            autant résoudre l'affaire en court.
            A mon sens c'est une manière pour nous aussi de continuer à rendre hommage tout en s'adonnant à une gentille parodie.")
create_post(syd, dsc_following_story,
            "Attention à ne pas rejouer la discussion du channel général, je rejoins quand même Paul sur son idée
            il faut un minimum introduire notre volonté de parodier Holmes si on ne veut pas créer un décalage de ton
            au moment où on souhaitera le parodier franchement.
            Pour le moment lorsqu'on relis le texte on a dut mal à discerner l'humour ou la parodie qui pourra intérvenir,
            c'est même franchement un texte plutôt triste.
            A mon avis, soit on retouche cette modification, soit on ajoute plus en amont du texte des éléments qui appellent
            à l'humour qu'on souhaitera utiliser plus tard.")
puts "-> #{Post.count} posts have been created."

puts "-> End of seeding"
