require_relative 'player'

class Game
	attr_accessor :human_player, :enemies
	@@enemies_life=0
	
	def initialize(name)
		@human_player = HumanPlayer.new(name)
        	@enemies = [Player.new("player1"), Player.new("player2"), Player.new("player3"), Player.new("player4")]
    	end		
	
	def kill_player(enemie_to_delete)
		@enemies.each{|player| if player.name==enemie_to_delete then enemie_to_delete=player end }
		@enemies.delete(enemie_to_delete)
				
	end
	
	def is_still_ongoing?
		enemies_life = 0
		@enemies.each{|player| enemies_life += player.life_points }
		(@human_player.life_points>0 &&  enemies_life>0)? true : false
	end

	def show_enemies
		@enemies.each{|player| puts player.name}
	end

	def show_players
		puts "Le joueur #{@human_player.name} a #{@human_player.life_points} points de vie"
		@enemies.each do |player|
                	puts "Le joueur #{player.name} a #{player.life_points} points de vie"
		end
	end


	def menu
        	puts "Quelle action veux-tu effectuer ?"
	        puts " "
	        puts "a - chercher une meilleure arme"
        	puts "s - chercher à se soigner "
	        puts " "
	        puts "attaquer un joueur en vue :"
		x=0
		@enemies.each do |player|
			print "#{x+1} - "
        		puts player.name
			x+=1
		end
		print ">>"
	end
	
	def menu_choice(next_move)
		if next_move != "a" && next_move != "s"
                        next_move = next_move.to_i
                end

                puts next_move

                if next_move == "a"
                        @human_player.search_weapon
                elsif next_move == "s"
			@human_player.search_health_pack
                elsif next_move.between?(1,@enemies.size) == true
                        next_move = next_move -1
                        puts "FIGHT !".green
                        @human_player.attacks(@enemies[next_move])
                        print ">>"
                        if @enemies[next_move].life_points == 0
                                puts "#{@enemies[next_move].name} est mort".green
                                kill_player(@enemies[next_move])
                        else
                                puts "#{@enemies[next_move].name} a #{@enemies[next_move].life_points} points de vie"
                        end
                else
                        puts "Cette commande n'existe pas ! Fait pas ta flippette et joue !".red
                end
		puts ""
		enemies_attack

	end

	def enemies_attack
		@enemies.each do |player|
			puts "Le joueur #{player.name} attaque #{@human_player}".red
			player.attacks(@human_player)
                end
		puts "#{@human_player.name} a #{@human_player.life_points} points de vie".green
	end
	def end
		if @human_player.life_points == 0
			puts "La partie est finie".red
                        puts "Loser ! Tu as perdu !".red
                        finish = true
		else
			puts "La partie est finie".green
                        puts "BRAVO ! TU AS GAGNE !".green
                        finish = true
		end
	end

end
