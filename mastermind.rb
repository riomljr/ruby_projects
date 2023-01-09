module Options 
  OPTIONS = ["orange", "red", "blue", "green", "yellow", "brown"]
end 

class Player
  include Options
  attr_reader :colors
  def initialize(name)
    @name = name
    @colors =[]
  end

  def get_colors
    print "(1)orange,(2)red, (3)blue, (4)green, (5)yellow, (6)brown \n Pick four Colors! \n"
    for i in 1...5
      puts "Pick Color number #{i}"
      begin
        input = gets.chomp
        raise if OPTIONS.include?(input) == false
        raise if @colors.include?(input)
      rescue
        puts "error please correct spelling or select a different color"
        retry
      else
        @colors.push(input)
      end
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