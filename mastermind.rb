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

    print "\norange, red, blue, green, yellow, brown \n  \nPick four colors from the list above! \n \n"
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

class Computer
  include Options
  attr_reader :computer_colors
  def initialize(name)
    @name = name
    @computer_colors =[]
  end

  def choose_rand_colors
    for i in 0...4
      begin
        random_color =OPTIONS[rand(5)]
        raise if @computer_colors.include?(random_color)
      rescue 
        retry
      else
        @computer_colors.push(random_color)
      end
    end
  end

end

class Game

end

comp_player = Computer.new("AI1")
comp_player.choose_rand_colors
print comp_player.computer_colors