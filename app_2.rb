require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def welcome
	puts "------------------------------------------------"
	puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
	puts "|Le but du jeu est d'être le dernier survivant !|"
	puts "-------------------------------------------------"
end

def fight_menu(player1, player2)  			#affiche un menu pour demander a l'utilisateur de choisir sa prochaine action
	puts "Quelle action veux-tu effectuer ?"
	puts " "
	puts "a - chercher une meilleure arme"
	puts "s - chercher à se soigner "
	puts " "
	puts "attaquer un joueur en vue :"
	print "0 - "
	player1.show_state
	print "1 - "
        player2.show_state
	print ">>"
end

def version_2
	
	puts "Quel est ton prenom ?"		
	print ">>"

	player = gets.chomp				#recupere le nom de l'utilisateur pour appeler son personnage


	user = HumanPlayer.new(player)			#initialisation du personnage HumanPlayer
	player1 = Player.new("Josiane")			#initialisation d'un player bot
        player2 = Player.new("Jose")			#initialisation d'un 2eme player bot
	
	puts "Passons a la phase d'attaque"
        
        while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)  #boucle tant que le joueur a de la vie et que au moins un des 2 bots a de la vie
			
			fight_menu(player1, player2)	#affiche le menu de combat
			next_move = gets.chomp.to_s	#recupere le choix d'action de l'utilisateur
			
			case next_move			#en fonction du choix definit par l'utilisateur nous appliquons une action specifique
				when "a"
					user.search_weapon		#lance la recherche d'une arme plus puissante
				when "s"
					user.search_health_pack		#lance la recherche d'un pack de vie
				when "0"
					puts "FIGHT !".green	
					user.attacks(player1)		#lance l'attaque de l'utilisateur sur le player 1
					print ">>"
					player1.show_state
				when "1"
					puts "FIGHT !".green
					user.attacks(player2)		#lance l'attaque de l'utilisateur sur le player 2
					print ">>"
					player2.show_state
				else
					puts "Cette commande n'existe pas ! Fait pas ta flippette et joue !".red
				end
			puts ""
			if Player.players_life > 0 			#verifie si il reste des players encore en vie
				puts "Les autres joueurs attaquent".red								#apres l'action de l'utilisateur, chaque player encore en vie va l'attaquer
				Player.all_players.each{|player| if player.life_points>0 && user.life_points>0 then player.attacks(user)end }		#meme si l'utilisateur n'a pas fait la bonne commande, il sera attaque. Mais si le personnage est succombe a l'une des attaques ... pas besoin de continuer a le massacrer, il a deja assez honte !
			else
				puts "Il n'y a plus de players en etat de combattre"
			end
			user.show_state
	end
	
	if player1.life_points == 0 && player2.life_points == 0 	#une fois que la boucle est termine, on recherche l'equipe gagnante
		pust "--------------------".green
		puts "La partie est finie".green
		puts "BRAVO ! TU AS GAGNE !".green
	else 								#si l'un des 2 bots a de la vie, cela veut dire que le user n'a plus de vie et a donc perdu
		
		puts "--------------------".red
		puts "La partie est finie".red
		puts "Loser ! Tu as perdu !".red
	end


end

def perform
	welcome
	version_2
end

perform
