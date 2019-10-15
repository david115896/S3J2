require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def version_1
	#creation des 2 joueurs
	player_1 = Player.new("Josiane")
	player_2 = Player.new("Jose")
	
	#affichage de l'etat des joueurs avant le debut du combat
	puts "Voici l'etat de chaque joueur "
	Player.all

	puts "Passons a la phase d'attaque"
	
	while player_1.life_points > 0 && player_2.life_points > 0  #boucle tant que les 2 personnes ont plus que 0 de vie
		player_1.attacks(player_2) #attaque du premier jour sur le deuxieme
		if player_2.life_points>0 	#si le deuxieme joueur a survecu a l'attaque, il reposte
			player_2.attacks(player_1)
		end
		puts ""
		puts "Voici l'etat de nos joueurs : "	#affichage de la vie restante des joueurs apres le tour de combat
		player_1.show_state
		player_2.show_state
		puts ""	
		 
	end

	puts ""
       	puts "combat fini" 
	if player_1.life_points == 0  #si le premier jour n'a plus de vie, le 2eme a gagne. sinon inversement
		puts "#{player_2.name} a gagne".green
       	else
		puts "#{player_1.name} a gagne".green
	end

end
	

def perform
	version_1
end

perform

