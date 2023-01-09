module Options 
  OPTIONS = ["orange", "red", "blue", "green", "yellow", "brown"]
  WON = ["Black", "Black", "Black", "Black"]
end 

class Player
  include Options
  attr_reader :colors
  def initialize(name)
    @name = name
    @colors =[]
  end

  def get_colors
    @colors.clear
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

  def choose_colors
    for i in 0...4
      begin
        random_color = OPTIONS[rand(5)]
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
  include Options
  def human_guess(player, computer_player)
    @pegs = []
    puts computer_player.computer_colors

    player.get_colors
    human = player.colors
    computer = computer_player.computer_colors
    
    human.each do |color|
      if computer.include?(color)
        human.find_index(color) == computer.find_index(color) ? @pegs.push("Black") : @pegs.push("White")
      end
    end
    p @pegs
  end

  def play()
    
    player1 = Player.new("Human")
    comp_player = Computer.new("AI1")
    comp_player.choose_colors
    @won = @pegs == ["Black", "Black", "Black", "Black"]
    
    for i in 0...12
      human_guess(player1, comp_player)
      if WON == @pegs 
        print "YOU WON! WOOHOO!"
        break
      else
         @pegs.clear
      end
      if i == 12
        print "Aww you didn't figure out the code :( Better luck tomorrow"
      end 
    end
  end

end

Game.new.play
