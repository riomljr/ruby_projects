
class Player
  attr_reader :colors
  @options = ["orange", "red", "blue", "green", "yellow", "brown"]
  def initialize(name)
    @name = name
    @colors =[]
  end

  def get_colors
    print "(1)orange,(2)red, (3)blue, (4)green, (5)yellow, (6)brown \n Pick four Colors! \n"
    for i in 1...5
      puts " Choose Color number #{i}"
      @colors.push(gets.chomp)
    end
  end

end

class Board

end

class Game

end

player1 = Player.new("Jefrrey")
player1.get_colors

print player1.colors