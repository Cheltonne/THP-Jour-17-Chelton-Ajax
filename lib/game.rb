require 'pry'
require_relative 'player'
class Game
  attr_accessor :human_player, :ennemies

  def initialize(player_name)
    @human_player = HumanPlayer.new(player_name)
    self.ennemies = []
    4.times do |i|
      @ennemies << Player.new("cpu_#{i}")
    end
  end

  def kill_player(victim)
        @ennemies = @ennemies - [victim]
  end

  def is_still_ongoing?
    if human_player.life_points > 0 && @ennemies != []
      return true
    else
      return false
    end
  end 

  def show_players
    puts "Il te reste #{human_player.life_points} points de vie. Il reste #{ennemies.length} ennemis en jeu.\n\n"
  end

  def menu
    puts "Voici les differents choix possibles, entre la lettre ou le chiffre correspondant a ton choix :"
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner\n\n"
    puts "Attaquer un joueur en vue :"
    i = 0
    @ennemies.each do |ennemy|                           #On verifie pour chaque ennemi qu'il lui reste bien des PV, si c'est le cas, on les affiche, et on lui affecte un numero correspondant a sa place dans l'array @ennemies.
      if ennemy.life_points > 0
        puts "#{i} - Ennemi #{i} a #{ennemy.life_points} points de vie."
        i += 1
      end
    end
    puts ""
    puts "Quel est ton choix ?"
    print "> "
    return player_action = gets.chomp
  end

  def menu_choice(player_action)
    if @ennemies == []
      return false
    end
    if player_action == 'a'
      human_player.search_weapon
    elsif player_action == 's'
      human_player.search_health_pack
    elsif player_action == "0"
      human_player.attacks(ennemies[0])
    elsif player_action == "1"
      human_player.attacks(ennemies[1])
    elsif player_action == "2"
      human_player.attacks(ennemies[2])
    elsif player_action == "3"
      human_player.attacks(ennemies[3])
    else
      puts "Ce choix n'existe pas."
    end
    @ennemies.each do |i|
      if i.life_points <= 0
        kill_player(i)
      end
    end
    ennemies_attack
  end

  def ennemies_attack
      @ennemies.each do |ennemy|
        ennemy.attacks(human_player)
      end
  end

  def end
    if human_player.life_points >= 1
      puts "Winner winner, chicken dinner"
    else
      puts "Game over..."
    end
  end
end #Fin de la definition de classe Game