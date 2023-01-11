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
    print "\nPick four colors from the list above! \n \n"
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
  attr_reader :correct_colors
  attr_reader :wrong_colors
  attr_accessor :unknown_colors

  def initialize(name)
    @name = name
    @computer_colors = []
    @computer_pegs = []
    @correct_colors = []
    @wrong_colors = []
    @temp_colors = ["orange", "red", "blue", "green", "yellow", "brown"]
    @unknown_colors =[]
    @code_to_crack =[]
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

  def human_code_input
    for i in 1...5
      puts "choose color #{i} from #{OPTIONS}?"
      begin
        player_feedback = gets.chomp.downcase
        raise if OPTIONS.include?(player_feedback) == false
      rescue
        puts "Please only select from #{OPTIONS}"
        retry
      else
        @code_to_crack.push(player_feedback)
      end
    end
  end
  
  def compare_first_four
    guess = @computer_colors.uniq
    guess.each do |color|
      if @code_to_crack.include?(color) 
        if guess.find_index(color) == @code_to_crack.find_index(color)
          @computer_pegs.push("Black")
          @correct_colors.push(color)
        else
          @computer_pegs.push("White")
          @correct_colors.push(color)
        end
      else
        @wrong_colors.push(color)
      end
    end
  end

  def send_guess
    print "My guess is #{@computer_colors} \n"
  end
  
  def results_first_four
    @known = (@correct_colors.concat(wrong_colors)).uniq
    @unknown = OPTIONS - @known

    case @correct_colors.length
    when 4
      @computer_colors.clear
      @computer_colors = @known
      send_guess()
    when 3
      @computer_colors.clear
      @computer_colors = @correct_colors.push(@unknown[0])
      send_guess()
    when 2
      @computer_colors.clear
      @computer_colors = @correct_colors + @unknown_colors
      send_guess()
    end
  end
 
  def 
  def first_four_guesses
    human_code_input()
    num = 5
    guess = []
    for i in 1...5
      color = OPTIONS[num]
      @computer_colors = [color] * 4 
      print "My guess is #{@computer_colors} \n"
      compare_first_four()
      results_first_four()
      num -= 1
    end
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

  def computer_guesser ()
    comp = Computer.new("Shuffler")
    comp.computer_guess
  end


end

comp = Computer.new("Shuffler")
comp.first_four_guesses


