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

def fight_menu(player1, player2)
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
end

def version_2
	
	puts "Quel est ton prenom ?"
	print ">"

	player = gets.chomp
	while player.class!=String
		player = gets.chomp	

	end
	user = HumanPlayer.new(player)
	player1 = Player.new("Josiane")
        player2 = Player.new("Jose")
	
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
			
			Player.all_players.each{|player| if player.life_points>0 then player.attacks(user)end }
			user.show_state

		elsif player1.life_points == 0 && player2.life_points == 0
			puts "La partie est finie".green
			puts "BRAVO ! TU AS GAGNE !".green
			finish = true

		elsif   user.life_points == 0
                        user.show_state
                        puts "La partie est finie".red
                        puts "Loser ! Tu as perdu !".red
                        finish = true

		else
			puts "BUG"
                end
        end


end

def perform
	welcome
	version_2
end

perform
