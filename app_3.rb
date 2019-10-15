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

def version_3
	
	puts "Quel est ton prenom ?"
	print ">"
	player = gets.chomp
		
	my_game = Game.new(player)
	user = my_game.human_player


	puts "Passons a la phase d'attaque".green
	while my_game.is_still_ongoing? == true
		my_game.menu
		next_move = gets.chomp
		my_game.menu_choice(next_move)
	end
	puts ""
	my_game.end
end

def perform
	welcome
	version_3
end

perform
