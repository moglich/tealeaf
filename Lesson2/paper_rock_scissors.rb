#Paper Rock Scissors OO game

class Hand
  CHOICES = ['p', 'r', 's']
  attr_accessor :hand
end

class Players < Hand
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{@name} choice: #{self.hand}"
  end
end

class User < Players
  def pick_hand
    begin
      puts "Coose your hand (p/r/s):"
      h = gets.chomp.downcase
    end until CHOICES.include?(h)
    @hand = h
  end
end

class Computer < Players
  def pick_hand
    @hand = CHOICES.sample
  end
end

class Game
  def initialize
    puts "Game started!"
    puts "Whats your name?"
    name = gets.chomp
    @player = User.new(name)
    @computer = Computer.new("robot")
  end

  def play
    @player.pick_hand
    @computer.pick_hand

    puts "--------"
    ["Paper", "Rock", "Scissors"].each do |hand|
      sleep 0.7
      puts hand
    end
    puts "--------"

    puts @player
    puts @computer

    winner?
  end

  def winner?
    puts ""

    if @player.hand == @computer.hand
      puts "It's a tie!"
    elsif (@player.hand == 'p' && @computer.hand == 'r') || (@player.hand == 'r' && @computer.hand == 's')\
          || (@player.hand == 's' && @computer.hand == 'p')
      puts "You won #{@player.name}!"
    else
      puts "Computer #{@computer.name} won!"
    end
  end

end

game = Game.new

begin
  system 'clear'
  game.play

  puts "Replay? [Y/n]"
end until 'n' == gets.chomp.downcase

