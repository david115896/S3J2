

class Player   
	attr_accessor :name, :life_points  	#chaque player a un nom attribue et un nombre de point de vie. Ces variables sont affichables et modifiables
	@@life_sum = 0				
	@@all_players = Array.new			#Tableau qui repertorie l'ensemble des joueurs bots

	def initialize(new_name)
		@name = new_name
		
		if self.class == Player		#creation de ces attributs seulement pour la classe Player.
			@life_points=10
			@@all_players << self	#increment le tablea all_players de chaque nouveau player
		end

	end
	
	def self.all
		@@all_players.each do |player|	#affiche pour chaque player son nom et sa vie restante
			puts "player : #{player.name}"
			puts "life : #{player.life_points}"
		end
	end

	def self.all_players			#retourne la liste de tout les players
		return @@all_players
			
	end

	def show_state				#affiche l'etat actuel d'un player en particulier. Si sa vie est de 0, il est definit comme mort
		if @life_points > 0
			puts "#{@name} a #{@life_points} points de vie"
		else
			puts "#{@name} est mort".green
		end
	end

	def gets_damage(damage,attacked_player)		#inflige des dommages a un player a partir d'un nombre de dommage definit et son ID 
		attacked_player.life_points= attacked_player.life_points-damage
		if attacked_player.life_points<0 	#si la vie du player attaque est inferieur a 0 apres l'attque, celle-ci est forcee a 0 pour ne pas avoir de nombre negatif
			attacked_player.life_points=0 
		end
	end
	
	def attacks(attacked_player)			#realise l'attaque. 
		puts "#{name} attaque #{attacked_player.name}"
		damages = compute_damage		#recupere les dommages d'un player ou d'un HumanPlayer selon la classe de l'instance
		gets_damage(damages,attacked_player)	#appel la fonction gets_damage et envoie en parametre les dommages et le nom de lu player a attaquer
		puts "Il lui inflige #{damages} points de dommages"
		puts ""
	end
	
	def self.players_life				#somme l'ensemble des vies des players pour verifier s'il reste des survivants
		@@life_sum = 0
		@@all_players.each{|user| @@life_sum += user.life_points}
		return @@life_sum
	end

	private
	
	def compute_damage				#methode privee qui envoie un nombre de dommage aleatoire entre 1 et 6
		return rand(1..6)
	end
end


class HumanPlayer < Player				#classe HumanPlayer qui herite de la classe Player
	attr_accessor :weapon_level			#ajoute une variable weapon_level
	
	def initialize(name)				
		@weapon_level = 1			#variable specifique a la classe HumanPlayer
		@life_points = 100			#valeur differente que pour les players	
	
		super(name)
	end

	def show_state					#affiche le nom, la vie et le niveau d'arme d'un HumanPlayer
		puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}".green
	end 
	
	def search_weapon				#methode qui recherche une arme plus puissante que celle possedee par le HumanPlayer
		new_weapon_level = rand(1..6)		#definit un niveau aleatoire d'une nouvelle arme
		if @weapon_level < new_weapon_level	#si l'arme est meilleure que celle du joueur, alors l'arme du joueur est remplace par celle-ci
			@weapon_level = new_weapon_level
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends. Ton arme est maintenant de niveau #{@weapon_level}".green
		else
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle...".red
		end
	end

	def search_health_pack				#methode qui recherche un pack de vie
		puts new_life = rand(1..6)		#definit un pack de vie de maniere aleatoire
		
		if new_life.between?(2,5)		#suivant la valeur du pack, le jour peut gagner 50 ou 80 points de vie. Sans depasser 100 points de vie
			puts "Bravo, tu as trouvé un pack de +50 points de vie !".green
			if (@life_points + 50) > 100	#si la vie du joueur cumulee au pack de vie depasse 100, alors sa vie est force a 100
			       @life_points = 100
			else
		 		@life_points = @life_points + 50
			end		
			puts "Ta vie est maintenant de #{@life_points}".green

		elsif new_life == 6
			puts "Waow, tu as trouvé un pack de +80 points de vie !".green
			if (@life_points + 80) > 100
                               @life_points = 100
                        else
                                @life_points = @life_points + 80
                        end
			puts "Ta vie est maintenant de #{@life_points}".green

		else
			puts "Tu n'as rien trouvé... ".red
		end
	end

	private

	def compute_damage					##methode privee qui envoie un nombre de dommage aleatoire entre 1 et 6 et multiplie au niveau de l'arme
		return	rand(1..6) * @weapon_level
	end
end
