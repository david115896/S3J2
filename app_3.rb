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
	while player.class!=String
		player = gets.chomp	
	end
		
	my_game = Game.new(player)
	user = my_game.human_player

	puts "Passons a la phase d'attaque".green

	while my_game.is_still_ongoing? == true
		my_game.fight_menu
		next_move = gets.chomp
		if next_move != "a" && next_move != "s" 
			next_move = next_move.to_i
		end

		puts next_move

		if next_move == "a"
			user.search_weapon
		elsif next_move == "s"
                	user.search_health_pack
		elsif next_move.between?(1,my_game.enemies.size) == true
			next_move = next_move -1
			puts "FIGHT !".green
			user.attacks(my_game.enemies[next_move])
                        print ">>"
			if my_game.enemies[next_move].life_points == 0
                        	puts "#{my_game.enemies[next_move].name} est mort".green
				my_game.kill_player(my_game.enemies[next_move])
			else
				puts "#{my_game.enemies[next_move].name} a #{my_game.enemies[next_move].life_points} points de vie"
			end
                else
			puts "Cette commande n'existe pas ! Fait pas ta flippette et joue !".red
                end
                puts ""
		my_game.enemies_attack
	end

	my_game.end
	
end

def dede
	user = my_game.human_player
	puts my_game.human_player.name
	puts user.life_points
	puts user.name
	
	my_game.show_enemies
	
	my_game.kill_player("player1")
	puts "----------"
	my_game.show_enemies
	
end

def new
	puts "Passons a la phase d'attaque"
        finish=false
        while finish==false
		if user.life_points>0 && (player1.life_points > 0 || player2.life_points >0)
			#user.show_state
			fight_menu(player1, player2)
			next_move = gets.chomp.to_s
			case next_move
			when "a"
				user.search_weapon
			when "s"
				user.search_health_pack
			when "0"
				puts "FIGHT !".green
				user.attacks(player1)
				print ">>"
				player1.show_state
			when "1"
				puts "FIGHT !".green
				user.attacks(player2)
				print ">>"
				player2.show_state
			else
			 puts "Cette commande n'existe pas ! Fait pas ta flippette et joue !"
			end
			puts ""
			puts "Les autres joueurs attaquent".red		
			Player.all_players.each{|player| if player.life_points>0 then player.attacks(user)end }
			user.show_state
               end
        end


end

def perform
	welcome
	version_3
end

perform
