class Player
  attr_reader :name
  attr_reader :score
  attr_reader :input
  attr_reader :numbers_taken

  def initialize(name, score, input)
    @name = name
    @score = score
    @input = input
    @numbers_taken = []
  end

  private
  def add_score(input)
    @score += input.to_i
  end
  
  public
  def get_input()
      @mark = @name == "Player 1" ? "X" : "O"

      puts "#{@name} select a number to put your #{@mark}"
      begin
        @input = Kernel.gets.chomp.match(/\d+/)[0]
        raise if @numbers_taken.include?(@input)
      rescue
        puts "Error. Select a/another number"
        retry
      else
        add_score(@input)
        @numbers_taken.push(@input)
      end
  end

  def add(value)
    @numbers_taken.push(value)
  end

  def won? 
    @score == 15
  end
end

class Table < Player
  def initialize 
    @board = [[2, 7, 6], [9, 5, 1],[4, 3, 8]]
  end

  def display
    @board.each do |value|
      value.each {|val| print "|#{val}|"}
      puts "\n"
    end
  end

  def convert_table (input, player)
    @mark = player == "Player 1" ? "X" : "O"
    @board.each do |row|
      row.each do |value|
        row[row.find_index(value)] = @mark if value == input.to_i
      end
    end
  end

end

class Game < Table

  def play_turn(player, player2, grid)
    player.get_input
    grid.convert_table(player.input, player.name)
    grid.display
    player2.add(player.input)
  end

  def play()
    play1 = Player.new("Player 1", 0, 0)
    play2 = Player.new("Player 2", 0, 0)
    table = Table.new
    table.display
  
    for i in 0...8 do
      play_turn(play1, play2, table)

        if play1.won?
          puts "Player 1 Wins!"
          break
        end

      if (play1.numbers_taken.length > 8) && (play1.numbers_taken == play2.numbers_taken)
        puts "Aww it's a tie! :/ Better Luck Tommorow!" 
        break
      end

      play_turn(play2, play1, table)
        if play2.won?
          puts "Player 2 Wins!"
          break
        end
    end
  end
    
end



Game.new.play



