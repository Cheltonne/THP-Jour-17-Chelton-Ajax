require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------\n\n"

puts "Comment t'appelles-tu ?"
print "> "
player1 = HumanPlayer.new(gets.chomp)
ennemies = [cpu1 = Player.new("Goku"), cpu2 = Player.new("Saitama")]
while (player1.life_points >= 1 && cpu1.life_points >= 1) || (player1.life_points >= 1 && cpu2.life_points >= 1) #On verifie que le joueur est vivant, et qu'au moins l'un des ennemis est vivant en meme temps
  puts "Il te reste #{player1.life_points} points de vie, et tu as une arme de niveau #{player1.weapon_level}.\n\n"
  puts "Quelle action veux-tu effectuer ?\n"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner\n\n"
  puts "attaquer un joueur en vue :"
  puts "0 - Goku a #{cpu1.life_points} points de vie."
  puts "1 - Saitama a #{cpu2.life_points} points de vie\n\n"
  puts "Quel est ton choix ?"
  print "> "
  player_action = gets.chomp
  case player_action
  when 'a'
    player1.search_weapon
  when 's'
    player1.search_health_pack
  when "0"
    player1.attacks(cpu1)
  when "1"
    player1.attacks(cpu2)
  else
    puts "Ce choix n'existe pas. Tu sautes donc ton tour.\n\n"
  end
  if cpu1.life_points > 0 || cpu2.life_points > 0 #On verifie qu'au moins un des ennemis soit toujours vivant avant de lancer la contre-attaque
    puts "Les autres joueurs attaquent !"
  end
  ennemies.each do |ennemy| #On parcourt le tableau des ennemis, puis a chaque tour de boucle l'ennemi attaque, puis on verifie s'il a tue le joueur
    ennemy.attacks(player1)
    if player1.life_points < 1
      return false #On return false afin de sortir de la boucle si jamais le joueur a ete tue, et ainsi eviter qu'il ne soit a nouveau tue au prochain tour de boucle
    end
  end
end
if player1.life_points >= 1 #On sort enfin de la phase d'attaque, on verifie qui a gagne entre le joueur ou les ennemis
  puts "Winner winner, chicken dinner"
else
  puts "Game over..."
end