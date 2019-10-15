require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def welcome
	puts "----------------------------------------------------------------------------"
	puts "|			Bienvenue sur 'ILS VEULENT TOUS MA POO' ! 		 |"
	puts "|Le but du jeu est de tuer 10 adversaires avec le moins de coups possible !|"
	puts "|			Si tu bats mon score, je te paye une glace !		 |"
	puts "----------------------------------------------------------------------------"
end

def version_3
	
	puts "Quel est ton prenom ?"
	print ">"
	player = gets.chomp			#recupere le prenom du joueur
		
	my_game = Game.new(player)		#creer un partie de jeu		

	puts "Passons a la phase d'attaque".green
	while my_game.is_still_ongoing? == true		#tant que les questions de victoire ou defaite ne sont pas respecter le jeu continue
		my_game.new_players_in_sight		#integre de nouveaux adversaires dans le jeu
		my_game.menu				#affiche le menu de combat
		next_move = gets.chomp			#recupere le choix d'action du joueur
		my_game.menu_choice(next_move)		#envoie le choix pour realiser une action definie
	end
	puts ""
	my_game.end					#affiche le resultat du jeu
end

def perform
	welcome
	version_3
end

perform
