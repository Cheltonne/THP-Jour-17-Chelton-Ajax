require 'bundler'
Bundler.require

# require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Goku")
player2 = Player.new("Saitama")
puts "Voici l'etat de chaque joueur :\n\nGoku a #{player1.life_points} points de vie.\n\nSaitama a #{player2.life_points} points de vie.\n\n"
puts "Passons a la phase d'attaque !"

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


# binding.pry