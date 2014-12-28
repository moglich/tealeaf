#Blackjack OO version

class Card
  attr_reader :suit, :pip_face, :value

  def initialize(suit, pip_face, value)
    @suit = suit
    @pip_face = pip_face
    @value = value
  end

  def to_s
    "[#{pip_face}, #{suit}]"
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    ['clubs', 'diamonds', 'hearts', 'spades'].each do |suit|
      (2..10).each do |value|
        @cards << Card.new(suit, value.to_s, value)
      end
      @cards << Card.new(suit, "jack", 10)
      @cards << Card.new(suit, "queen", 10)
      @cards << Card.new(suit, "king", 10)
      @cards << Card.new(suit, "ace", 11)
    end
  end
end

class Shoe
  attr_reader :cards

  def initialize(number_of_decks)
    @cards = []
    number_of_decks.times do
      Deck.new.cards.each do |card|
        @cards << card
      end
    end
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end
end

module Hand
  def get_card(shoe)
    cards << shoe.cards.pop
  end

  def get_total
    total = 0
    ace_cnt = 0

    cards.each do |card|
      if card.value == 11
        ace_cnt += 1
      end
      total += card.value
    end

    while (total > Blackjack::BLACKJACK_AMOUNT) && (ace_cnt > 0)
      total -= 10
      ace_cnt -= 1
    end
    total
  end

  def show_hand
    puts
    puts "#{name}:"
    cards.each {|card| puts card}
    puts get_total
  end

  def blackjack?
    true if get_total == Blackjack::BLACKJACK_AMOUNT
  end

  def busted?
    get_total > Blackjack::BLACKJACK_AMOUNT
  end
end

class Player
  include Hand
  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @cards = []
    @name = name
  end

  def hit_again?
    loop do
      puts
      print "Hit or Stay? [h/s] "
      user_input = gets.chomp
      case user_input
      when 'h'
        return true
      when 's'
        return false
      else
        puts "Invalid input, try again!"
      end
    end
  end
end

class Dealer
  include Hand
  attr_reader :name
  attr_accessor :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

end

class Blackjack
  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    print "Whats your name? "
    p_name = gets.chomp
    @player = Player.new(p_name)
    @dealer = Dealer.new
    @shoe = Shoe.new(5)
  end

  def play
    2.times do
      @player.get_card(@shoe)
      @dealer.get_card(@shoe)
    end

    show_table

    exit if any_blackjack?

    while @player.hit_again? do
      @player.get_card(@shoe)
      show_table

      if @player.busted?
        puts "#{@player.name} is busted!"
        break
      end
    end

    while @dealer.get_total <= DEALER_HIT_MIN do
      @dealer.get_card(@shoe)
      show_table
    end

    puts
    puts ">>> #{get_winner} <<<"
    puts
  end

  def any_blackjack?
    if @player.blackjack?
      puts "#{@player.name} has a blackjack!"
      return true
    elsif @dealer.blackjack?
      puts "Dealer has a blackjack!"
      return true
    else
      return false
    end
  end

  def get_winner
    if @player.get_total > BLACKJACK_AMOUNT
      "Dealer won!"
    elsif @dealer.get_total > BLACKJACK_AMOUNT
      "#{@player.name} won!"
    elsif @player.get_total == @dealer.get_total
      "It's a push"
    elsif @player.get_total > @dealer.get_total
      "#{@player.name} won!"
    elsif @player.get_total < @dealer.get_total
      "#{@player.name} lost!"
    end
  end

  def show_table
    system 'clear'
    puts "--- Blackjack ---"
    @dealer.show_hand
    @player.show_hand
  end

  def reset_hands
    @player.cards = []
    @dealer.cards = []
  end
end


game = Blackjack.new

begin
  game.reset_hands
  game.play
  print "Do you want to play again? [Y/n] "
  replay = gets.chomp
end until replay == 'n'

puts "Goodbye!"
