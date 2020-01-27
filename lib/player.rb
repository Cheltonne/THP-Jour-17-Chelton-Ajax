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
    puts "Le joueur #{name} attaque le joueur #{player.name}."
    damage_dealt = compute_damage
    puts "Il lui inflige #{damage_dealt} de dommages."
    player.get_damage(damage_dealt)
  end

  def compute_damage
    return rand(1..6)
  end

end #Fin de la definition de la classe player