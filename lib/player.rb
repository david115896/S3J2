class Player
	attr_accessor :name, :life_points
	@@life_sum=0
	@@all_players=Array.new

	def initialize(new_name)
		@name=new_name
		
		if self.class==Player
			@life_points=10
			@@all_players << self
		end

	end
	
	def self.all
		@@all_players.each do |player|
			puts "player : #{player.name}"
			puts "life : #{player.life_points}"
		end
	end

	def self.all_players
		return @@all_players
			
	end

	def show_state
		if @life_points > 0
			puts "#{@name} a #{@life_points} points de vie"
		else
			puts "#{@name} est mort".green
		end
	end

	def gets_damage(damage,attacked_player)
		attacked_player.life_points= attacked_player.life_points-damage
		if attacked_player.life_points<0 
			attacked_player.life_points=0 
		end
		return attacked_player.life_points

	end
	
	def attacks(attacked_player)
		puts "#{name} attaque #{attacked_player.name}"
		damages = compute_damage
		gets_damage(damages,attacked_player)
		puts "Il lui inflige #{damages} points de dommages"
		puts ""
	end
	
	def self.players_life
		@@life_sum=0
		@@all_players.each{|user| @@life_sum += user.life_points}
		return @@life_sum
	end

	private
	
	def compute_damage
		return rand(1..6)
	end
end


class HumanPlayer < Player
	attr_accessor :weapon_level
	
	def initialize(name)
		@weapon_level = 1
		@life_points = 100
	
		super(name)
	end

	def show_state
		puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}".green
	end 
	
	def search_weapon
		new_weapon_level = rand(1..6)
		if @weapon_level < new_weapon_level
			@weapon_level = new_weapon_level
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends. Ton arme est maintenant de niveau #{@weapon_level}".green
		else
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle...".red
		end
	end

	def search_health_pack
		puts new_life = rand(1..6)
		
		if new_life.between?(2,5)
			puts "Bravo, tu as trouvé un pack de +50 points de vie !".green
			if (@life_points + 50) > 100
			       @life_points = 100
			else
		 		@life_points = @life_points + new_life
			end		
			puts "Ta vie est maintenant de #{@life_points}".green

		elsif new_life == 6
			puts "Waow, tu as trouvé un pack de +80 points de vie !".green
			if (@life_points + 80) > 100
                               @life_points = 100
                        else
                                @life_points = @life_points + new_life
                        end
			puts "Ta vie est maintenant de #{@life_points}".green

		else
			puts "Tu n'as rien trouvé... ".red
		end
	end

	private

	def compute_damage
		return	rand(1..6) * @weapon_level
	end
end


