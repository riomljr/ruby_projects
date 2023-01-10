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

  def initialize(name)
    @name = name
    @computer_colors = []
    @computer_pegs = []
    @correct_colors = []
    @wrong_colors = []
    @temp_colors = ["orange", "red", "blue", "green", "yellow", "brown"]
    @unknown_colors =[]
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

  def human_feedback_loop 
    for i in 1...5
      p "Is Peg #{i} black, white or none?"
      begin
        player_feedback = gets.chomp.downcase
        raise if PEGS.include?(player_feedback) == false
      rescue
        puts "Please only select from #{PEGS}"
        retry
      else
        if player_feedback == "white" || player_feedback == "black"
          @computer_pegs.push(player_feedback)
        end
      end
    end
  end
           
  def analyze
    if @computer_pegs.include?("white") || @computer_pegs.include?("black")
      @correct_colors.push(@computer_colors[0])
    else
      @wrong_colors.push(@computer_colors[0])
    end
  end

  def delete_wrong_color
   
    if @correct_colors == 4
      @computer_colors = @correct_colors
    else
      @wrong_colors.each do |color|
        if @temp_colors.include?(color)
          @temp_colors.delete(color)
        end
      end
      if @temp_colors.length == 4
        @computer_colors = @temp_colors
      else
        correct_colors.each do |color|
          if @temp_colors.include?(color) == false
            @unknown_colors.push(color)
          end
        end
        @computer_colors.push(unknown_colors[0])
        unknown_colors.shift
      end  
    end
  end

  def send_guess()
    print "Guess is #{@computer_colors} \n"
    human_feedback_loop()
    analyze()
    @computer_pegs.clear
  end

  def shuffle_guess
    5.times do 
      @computer_colors.shuffle
      send_guess()
      if @computer_pegs == WON
        print "YAY I WON, I'M THE BEST!"
        break
      end
    end
    if @computer_pegs != WON
      print "AWW I LOST :("
    end
  end


  def computer_guess
    for i in 1...5
      begin
        random_color = OPTIONS[rand(6)]
        raise if @computer_colors[0] == random_color
      rescue
        retry
      else
        @computer_colors = [random_color] * 4
        send_guess()
      end
    end
    delete_wrong_color()
    if @unknown_colors.length > 1
      @correct_colors.clear
      @wrong_colors.clear
      send_guess()
      delete_wrong_color()
    end
    if @computer_colors == 4
      shuffle_guess()
    end
  end




end

class HumanGuessGame 
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




