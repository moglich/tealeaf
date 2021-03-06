#Tic Tac Toe game, OO version

class Board
  attr_accessor :grid

  def initialize
    @grid = {}
    (1..9).each { |pos| @grid[pos] = ' ' }
  end

  def show
    system 'clear'
    puts "----  Tic Tac Toe  ----"
    puts
    puts "       |       |"
    puts "   #{@grid[1]}   |   #{@grid[2]}   |   #{@grid[3]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@grid[4]}   |   #{@grid[5]}   |   #{@grid[6]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@grid[7]}   |   #{@grid[8]}   |   #{@grid[9]}"
    puts "       |       |"
    puts ""
  end

  def get_empty_positions
    @grid.keys.select {|position| @grid[position] == ' '}
  end
end

class Player
  attr_reader :name, :mark, :player_type

  def initialize(name, mark, type = "computer")
    @name = name
    @mark = mark
    @player_type = type
  end

  def pick_field(board)
    unless board.get_empty_positions.empty?
      if self.player_type == "computer"
        field = board.get_empty_positions.sample
      else
        begin
          puts "Pick field #{self.name}:"
          field = gets.chomp.to_i
        end until board.grid[field] == ' '
      end
      board.grid[field] = self.mark
    else
      puts "It's a tie - no fields left!"
      exit
    end
  end
end

class Game
  def initialize
    @board = Board.new

    puts "What is your name?"
    username = gets.chomp
    @player = Player.new(username, 'X', "user")
    @computer = Player.new("Robot", 'O', "computer")
  end

  def play
    begin
      @board.show
      @player.pick_field(@board)
      @computer.pick_field(@board)
      @board.show
    end until winner?
    puts "Winner is: #{winner?}"
  end

  def winner?
    solution_combos = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

    solution_combos.each do |combo|
      return @player.name if @board.grid.values_at(*combo).count(@player.mark) == 3
      return @computer.name if @board.grid.values_at(*combo).count(@computer.mark) == 3
    end
    return nil
  end
end

Game.new.play
