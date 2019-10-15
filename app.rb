require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def version_1
	player_1 = Player.new("Josiane")
	player_2 = Player.new("Jose")
	
	puts "Voici l'etat de chaque joueur "
	Player.all

	puts "Passons a la phase d'attaque"
	finish=false
	while finish==false
		if player_1.life_points<=0 || player_2.life_points<=0 
			finish = true
			puts ""
			puts "combat fini"
			if player_1.life_points <=0
				puts "#{player_2.name} a gagne"
			else
				puts "#{player_1.name} a gagne"
			end
		else
			player_1.attacks(player_2)
			if player_2.life_points>0 
				player_2.attacks(player_1)
			end
			puts ""
			puts "Voici l'etat de nos joueurs : "

			player_1.show_state
			player_2.show_state
			puts ""	
		end 
	end
end
	

def perform
	version_1
end

perform

