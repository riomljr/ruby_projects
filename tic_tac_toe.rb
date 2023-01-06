class Player 
  attr_reader :name
  attr_reader :score
  attr_reader :input
  def initialize (name, score, input)
    @name = name
    @score = score
    @input = input
  end

  private
  def add_score(input)
    @score += input.to_i
    print "#{@name} if the Winner!" if @score >= 15 
  end
  
  public
  def get_input()
      @mark = @name == "Player 1" ? "X" : "O"
      puts "#{@name} select a number to put your #{@mark}"
      @input = Kernel.gets.match(/\d+/)[0]
      add_score(@input)
  end
  
  def won? 
    @score >= 15
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
        row[row.find_index(value)] = @mark if value == input.to_i
      end
    end
  end

end

class Game < Table

  def loop(player1, player2, grid)
   
    grid.display
    player1.get_input
    grid.convert_table(player1.input, player1.name)

    grid.display
    player2.get_input
    grid.convert_table(player2.input, player2.name)


  end

  

end

  play1 = Player.new("Player 1", 0, 0)
  play2 = Player.new("Player 2", 0, 0)
  table = Table.new


Game.new.play(play1, play2, table)



