require 'bundler'
Bundler.require
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------\n\n"
puts "Comment t'appelles-tu ?"
print "> "
my_game = Game.new(gets.chomp)                              #La partie est lancee !
while my_game.is_still_ongoing? == true
  my_game.show_players
  my_game.menu_choice(my_game.menu)
  # binding.pry
end
my_game.end


