require_relative 'player'

class Game
	attr_accessor :human_player, :enemies_in_sight, :players_left   #creer des variables pour creer une nouvelle partie 
	@@score=0							#calcul le score du joueur
	
	def initialize(name)
		@human_player = HumanPlayer.new(name)			#creer un nouveau joueur
		@players_left = 10					#definit le nombre de bots a tuer = objectif du jeu
		@enemies_in_sight = Array.new				#creer un tableau ou seront repertorier les bots
    	end		
	
	def kill_player(enemie_to_delete)				#recherche l'ID du bot et le supprime du tableau
		@enemies_in_sight.each{|player| if player.name==enemie_to_delete then enemie_to_delete=player end }
		@enemies_in_sight.delete(enemie_to_delete)
		@players_left = @players_left - 1			#decremente players_left a chaque bot tue
		puts "Il te reste #{@players_left} enemies a tuer"		
	end
	
	def is_still_ongoing?						#condition qui valide que le personnage est encore en vie et que l'objectif du jeu n'est pas atteint
		(@human_player.life_points > 0 && @players_left != 0)? true : false
	end

	def new_players_in_sight					#ajoute de nouveaux adversaires bots en fonction d'un lancement de de
		if @enemies_in_sight.size >= @players_left		#ajoute seulement si le nombre de jours en place est inferieur au nombre de joueur restant a tuer
			puts "Tous les joueurs sont déjà en vue"
		else
			next_enemies = rand(1..6)			# lance un de pour creer de nouveaux adversare
			if next_enemies.between?(2,4)			# entre 2 et 4, 1 nouvel adversaire est cree
				player_name = "Player_#{rand(0000..9999)}"
                                @enemies_in_sight << player_name=Player.new(player_name)
                                player_name.life_points = 100
				puts "Le player #{player_name.name} vient de rentrer en jeu avec #{player_name.life_points} points de vie".blue
			elsif next_enemies >= 5				# 5 ou 6, 2 nouveaux adversaires sont cree
				2.times do
					player_name = "Player_#{rand(0000..9999)}"	#on cree un nom avec un chiffre aleatoire
                                	@enemies_in_sight << player_name=Player.new(player_name)	#on cree un nouveau bot et on l'ajoute au tableau 
					player_name.life_points = 100					#on attribut 100 points de vie au bot
					puts "Le player #{player_name.name} vient de rentrer en jeu avec #{player_name.life_points} points de vie".blue		#on annonce la mise en jeu d'un nouveau bot
				end
			else 						#si le de est 1, aucun adversaire de creer
				puts "Tu as de la chance petit, pas de nouvel adversaire pour le moment .... Mais ca ne va pas tarder".red
			end
		end
	
	end

	def show_enemies
		@enemies_in_sight.each{|player| puts player.name}		#affiche l'ensemble des bots du presents en jeu
	end

	def show_players
		puts "Le joueur #{@human_player.name} a #{@human_player.life_points} points de vie"		#affiche l'etat du personnage et des bots
		@enemies_in_sight.each do |player|
                	puts "Le joueur #{player.name} a #{player.life_points} points de vie"
		end
	end


	def menu						#menu du combat qui permet a l'utilsateur de choisir l'action a realiser
        	puts "Quelle action veux-tu effectuer ?"
	        puts " "
	        puts "a - chercher une meilleure arme"
        	puts "s - chercher à se soigner "
	        puts " "
	        puts "attaquer un joueur en vue :"
		x=0
		@enemies_in_sight.each do |player|		#affiche l'ensemble des bots en vie dans le jeu et disponible pour attaquer
			print "#{x+1} - "
        		puts player.name
			x+=1
		end
		print ">>"
	end
	
	def menu_choice(next_move)				#realise l'action choisit par le joueur
		if next_move != "a" && next_move != "s"		#si le personnage a choisit un chiffre, il le convertit en integer pour le comparer au numero du bot qu'il souhaite attaquer
                        next_move = next_move.to_i
                end

                if next_move == "a"
                        @human_player.search_weapon		
                elsif next_move == "s"
			@human_player.search_health_pack
                elsif next_move.between?(1,@enemies_in_sight.size) == true
                        next_move = next_move -1		#retire 1 a next_move ce qui permettait de ne pas confondre avec une lettre qui a une valeur integer de 0
                        puts "FIGHT !".green
                        @human_player.attacks(@enemies_in_sight[next_move])
                        print ">>"
                        if @enemies_in_sight[next_move].life_points == 0		#utilise next_move pour trouver la position du bot dans le tableau
                                puts "#{@enemies_in_sight[next_move].name} est mort".green
                                kill_player(@enemies_in_sight[next_move])
                        else
                                puts "#{@enemies_in_sight[next_move].name} a #{@enemies_in_sight[next_move].life_points} points de vie"
                        end
                else
                        puts "Cette commande n'existe pas ! Fait pas ta flippette et joue !".red
                end
		puts ""
		enemies_attack			#lance la methode pour que tout les bots en jeu attaque le joueur
		@@score += 1

	end

	def enemies_attack
		@enemies_in_sight.each do |player|			#boucle sur l'ensemble des bots en jeu et attaque le joueur
			puts "Le joueur #{player.name} attaque #{@human_player.name}".red
			player.attacks(@human_player)
                end
		puts "Le joueur #{@human_player.name} a #{@human_player.life_points} points de vie".yellow 
	end
	
	def end
		if @human_player.life_points == 0
			puts "--------------------".red
			puts "La partie est finie".red
                        puts "Loser ! Tu as perdu !".red
		else
			puts "---------------------".green
			puts "La partie est finie".green
                        puts "BRAVO ! TU AS GAGNE !".green
			puts "Ton score est de #{@@score}"			# si le joueur a gagner .... meme si ca n'arrivera pas ... il affiche son score
		end
	end

end
