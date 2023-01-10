module Options 
  OPTIONS = ["orange", "red", "blue", "green", "yellow", "brown"]
  WON = ["Black", "Black", "Black", "Black"]
  RULES = "**Give a black peg for the correct color in the correct position. n\ 
  **Give a White peg if color exists in your secret code but not in the correct position. n/
  Pegs should not be in a particular order"
  PEGS = ["black", "white", "none"]
end 

class Player
  include Options
  attr_accessor :colors

  def initialize(name)
    @name = name
    @colors =[]
  end

  def get_colors
    #@colors.clear
    p OPTIONS
    print"\nPick four colors from the list above! \n \n"
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
    @computer_colors = []
    @computer_pegs = []
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

  def computer_guess(computer)
    
    random_color = OPTIONS[rand(5)]

  end

  def human_input_loop 
    for i in 1...5
      p "Is Peg #{i} black, white or none?"
      begin
        player_feedback = gets.chomp.downcase
        raise if PEGS.include?(player_feedback) == false
      rescue
        puts "Please only select from #{PEGS}"
        retry
      else
        if player_feedback == "white" || player_feedback == 'black'
          @computer_pegs.push(player_feedback)
        end
      end
    end
  end

  def get_human_input
    puts "TYPE HELP FOR HELP W/RULES"
    human_input_loop()
    
  end


end

class Game 
  include Options

  def human_guess(player, computer_player)
    @pegs = []

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

  def play_human_guess()
    player1 = Player.new("Human")
    comp_player = Computer.new("AI1")

    comp_player.choose_colors

    for i in 0...12
      human_guess(player1, comp_player)
      if WON == @pegs 
        print "YOU WON! WOOHOO!"
        break
      else
         @pegs.clear
         player1.colors.clear
      end
      if i == 12
        print "Aww you didn't figure out the code :( Better luck tomorrow"
      end 
    end
  end

end


comp = Computer.new("AI1")
comp.get_human_input
