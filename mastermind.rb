module Options 
  OPTIONS = ["orange", "red", "blue", "green", "yellow", "brown"]
  WON = ["Black", "Black", "Black", "Black"]
  RULES = "                          HERE ARE THE RULES
  If you are the codemaster: give me a code to brek. 
  If you are the codebreaker: Try to break my code and I will give you feedback
      Black pegs = correct place and color. 
      White pegs = correct color but wrong place."
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
    puts "\n Pick four colors from the list as your guess \n \n"
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
    @unknown = []
    @known = []
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
      @known.push(color)
      if @code_to_crack.include?(color)
        @correct_colors.push(color)
      else
        @wrong_colors.push(color)
      end
    end
  end

  def restart_varibbles
    @computer_pegs.clear
    @unknown.clear
  end

  def compare_remaining_gueses

    restart_varibbles()
    @computer_colors.each do |color|
      @known.push(color)
      if @code_to_crack.include?(color) 
        @correct_colors.push(color)
      else
        @wrong_colors.push(color)
      end
    end
  end

  def send_guess
    print "My guess is #{@computer_colors} \n"
  end

  def shuffler
    for i in 0...8
      clean_guess = @correct_colors.uniq
      @computer_colors = clean_guess.shuffle
      send_guess()
      compare_remaining_gueses()
      if @computer_colors == @code_to_crack
        print "I WIN! I'M THE BEST!"
        break
      end
      if i == 7
        print "AWW I LOST! :("
      end
    end
    
  end

  def process_results
    @unknown = OPTIONS - @known
    correct_amount = @correct_colors.length
   
    @computer_colors.clear
    case correct_amount
    when 4
      @computer_colors = @known
      shuffler()
    when 3
      @computer_colors = @correct_colors.push(@unknown[0])
      send_guess()
      compare_remaining_gueses()
      process_results()
    when 2
     @correct_colors.push(@unknown[0]) 
     @correct_colors.push(@unknown[1])
      shuffler()
    end
  end

  def first_four_guesses
    human_code_input()
    num = 5
    guess = []
    for i in 1...5
      color = OPTIONS[num]
      @computer_colors = [color] * 4 
      print "My guess is #{@computer_colors} \n"
      compare_first_four()
      num -= 1
    end
    process_results()
  end

end

class Game
  include Options
  SELECTION = ["codebreaker", "codemaster"]

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
    p "Your pegs are #{@pegs} \n"
  end

  def play_human_guess()

    player1 = Player.new("Human")
    comp_player = Computer.new("AI1")

    comp_player.choose_colors

    for i in 0...12
      human_guess(player1, comp_player)
      if @pegs == WON
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
    comp.first_four_guesses
  end

  def choose_game()
    puts " \n ********************* WELCOME TO MASTERMIND!! **********************************"
    puts RULES

    puts " \n Do you want to be the codebreaker or the codemaster?"
    begin
      pick = gets.chomp
      raise if !SELECTION.include?(pick)
    rescue
      puts "Please retry. Only type codebreaker or codemaster"
      retry
    else
      if pick == "codemaster"
        computer_guesser()
      else 
        play_human_guess()
      end
    end
  end

end

Game.new.choose_game





