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
while (player1.life_points >= 1 && cpu1.life_points >= 1) || (player1.life_points >= 1 && cpu2.life_points >= 1)
  puts "Il te reste #{player1.life_points} points de vie.\n\nQuelle action veux-tu effectuer ?\n"
  puts "a - chercher une meilleure arme\ns - chercher à se soigner\n\n"
  puts "attaquer un joueur en vue :\n0 - Goku a #{cpu1.life_points} points de vie\n1 - Saitama a #{cpu2.life_points} points de vie\n\n"
  puts "Quel est ton choix ?"
  print "> "
  player_action = gets.chomp
  if player_action == 'a'
    player1.search_weapon
  elsif player_action == 's'
    player1.search_health_pack
  elsif player_action == "0"
    player1.attacks(cpu1)
  elsif player_action == "1"
    player1.attacks(cpu2)
  else
    puts "Ce choix n'existe pas."
  end
  if cpu1.life_points > 0 || cpu2.life_points > 0
    puts "Les autres joueurs attaquent !"
  end
  ennemies.each do |ennemy|
    ennemy.attacks(player1)
    next if ennemy.life_points < 0
  end
end
if player1.life_points >= 1
  puts "Winner winner, chicken dinner"
else
  puts "Game over..."
end