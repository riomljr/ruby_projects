class Player 
  attr_reader :name
  attr_reader :score
  attr_reader :input
  def initialize (name, score, input)
    @name = name
    @score = score
    @input = input
    @numbers_taken =[]
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
  
  def won? 
    @score == 15
  end
end

class Table < Player
  def initialize 
    @board = [
      [2, 7, 6],
      [9, 5, 1],
      [4, 3, 8]
    ]
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
        if value == input.to_i
          row[row.find_index(value)] = @mark
        end
      end
    end
  end

end

class Game < Table

  def play(player, grid)
   
    grid.display
    for i in 0...8 do 
        player.get_input
        numbers_taken.push(player.input)
        grid.convert_table(player.input, player.name)
        grid.display
  
    end
  end
end

  play1 = Player.new("Player 1", 0, 0)
  play2 = Player.new("Player 2", 0, 0)
  table = Table.new


Game.new.play(play1, play2, table)



