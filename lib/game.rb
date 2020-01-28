require 'pry'
require_relative 'player'
class Game
  attr_accessor :human_player, :players_left, :ennemies_in_sight

  def initialize(player_name)
    @players_left = 10
    @human_player = HumanPlayer.new(player_name)
    self.ennemies_in_sight = []
    4.times do |i|
      @ennemies_in_sight << Player.new("cpu_#{i}")
    end
  end

  def kill_player(victim)
        @ennemies_in_sight = @ennemies_in_sight - [victim]
  end

  def is_still_ongoing?
    if human_player.life_points > 0 && @ennemies_in_sight != [] #Ceci signifie "Tant que le joueur est vivant ET que la liste des ennemis n'est pas un tableau vide" 
      return true
    else
      return false
    end
  end 

  def show_players
    puts "Il te reste #{human_player.life_points} points de vie, et tu possedes une arme de niveau #{human_player.weapon_level}. Il reste #{ennemies_in_sight.length} ennemis en jeu.\n\n"
  end

  def menu
    puts "Voici les differents choix possibles, entre la lettre ou le chiffre correspondant a ton choix :"
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner\n\n"
    puts "Attaquer un joueur en vue :"
    i = 0
    @ennemies_in_sight.each do |ennemy|                           #On verifie pour chaque ennemi qu'il lui reste bien des PV, si c'est le cas, on les affiche, et on lui affecte un numero correspondant a sa place dans l'array @ennemies.
      if ennemy.life_points > 0
        puts "#{i} - Ennemi #{ennemy.name} a #{ennemy.life_points} points de vie."
        i += 1
      end
    end
    puts ""
    puts "Quel est ton choix ?"
    print "> "
    return player_action = gets.chomp
  end

  def menu_choice(player_action)
    if @ennemies_in_sight == []
      return false
    end
    if player_action == 'a'
      human_player.search_weapon
    elsif player_action == 's'
      human_player.search_health_pack
    elsif ennemies_in_sight[player_action.to_i] != nil
      human_player.attacks(ennemies_in_sight[player_action.to_i])
    else
      puts "⚠️ Ce choix n'existe pas. Tu as perdu un tour pour rien ! ⚠️\n\n"
    end
    @ennemies_in_sight.each do |i|
      if i.life_points <= 0
        kill_player(i)
      end
    end
    ennemies_attack
  end

  def ennemies_attack
      @ennemies_in_sight.each do |ennemy|
        ennemy.attacks(human_player)
        if human_player.life_points < 1
          return false
        end
      end
  end

  def end_game
    if human_player.life_points >= 1
      puts "Winner winner, chicken dinner"
    else
      puts "Game over..."
    end
  end

  def new_players_in_sight
    if players_left == ennemies_in_sight.length
      puts "Tous les joueurs sont déjà en vue.\n\n"
    end
    dice = rand(1..6)
    case dice
    when 1
      puts "Aucun nouveau joueur adverse n'arrive.\n\n"
    when  [2.. 4]
        ennemies_in_sight << Player.new("joueur_#{rand(1..50)}")
        puts "Un nouvel ennemi apparait !\n\n"
    when 5 || 6
      2.times do |new_player_in_sight|
        ennemies_in_sight << Player.new("joueur_#{rand(1..50)}")
        puts "Deux nouveaux ennemis apparaissent !\n\n"
      end
    end
  end
end #Fin de la definition de classe Game