class Player
attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{name} a #{life_points} points de vie."
  end

  def get_damage(damage)
    @life_points -= damage
    if @life_points <= 0
      puts "le joueur #{name} a ete tue !"
    end
  end

  def attacks(player)
    if life_points < 1
      return true
    end
    puts "Le joueur #{@name} attaque le joueur #{player.name}."
    damage_dealt = compute_damage
    puts "Il lui inflige #{damage_dealt} de dommages."
    player.get_damage(damage_dealt)
  end

  def compute_damage
    return rand(1..6)
  end

end #Fin de la definition de la classe Player

class HumanPlayer < Player
attr_accessor :weapon_level

def initialize(name)
  @life_points = 100
  @weapon_level = 1
end

def show_state
  puts "#{name} a #{life_points} points de vie, et une arme de niveau #{weapon_level}."
end

def compute_damage
  rand(1..6) * @weapon_level
end

def search_weapon
  new_weapon_level = rand(1..6)
  puts "Tu as trouve une arme de niveau #{new_weapon_level}"
  if new_weapon_level > @weapon_level
    @weapon_level = new_weapon_level
    puts "Oh que oui, elle est meilleure que ton arme actuelle, tu la prends donc."
  else
    puts "Oh que non...elle n'est pas mieux que ton arme actuelle..."
  end
end

def search_health_pack
  dice_result = rand(1..6)
  if dice_result == 1
    puts "Tu n'as rien trouve..."
  elsif dice_result >= 2 || dice_result <= 5
    puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    if @life_points >= 51
      until @life_points == 100
        @life_points += 1
      end
    else
      @life_points += 50
    end
  else
    puts "OH QUE OUI, tu as trouvé un pack de +80 points de vie !"
    if @life_points >= 21
      until @life_points == 100
        @life_points += 1
      end
    else
      @life_points += 80
    end
  end
end
end #Fin de la definition de classe HumanPlayer