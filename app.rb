require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Goku")
player2 = Player.new("Saitama")
puts "Voici l'etat de chaque joueur :"
puts "Goku a #{player1.life_points} points de vie.\nSaitama a #{player2.life_points} points de vie."
puts "Passons a la phase d'attaque !\n\n"

while player1.life_points >= 1 || player2.life_points >= 1
  player2.attacks(player1)
  if player1.life_points <= 0
    break
  end
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  end
  puts ""
end