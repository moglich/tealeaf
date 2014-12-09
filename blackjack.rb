#Blackjack 21

def input_valid? (input, regexp)
  input =~ regexp ? true : false
end


def new_deck
  deck = {  clubs: [],
            diamonds: [],
            hearts: [],
            spades: [] }


  deck.each_key do |card_type|
    (1..11).each do |value|
      deck[card_type].push value
    end
  end
  return deck
end


def get_card (cards) #{:type => [1, 2, 3, 4], :type => [1, 2, 3, 4]}
  card_type = cards.keys.sample
  card_value = cards[card_type].sample

  cards[card_type].delete card_value

  card = { card_type => card_value }

  return card
end


def get_card_value cards
  value = 0
  cards.each do |card|
    card.each_value { |val| value += val }
  end
  return value
end


def get_valid_input (statement, valid_input)
  loop do

    puts statement
    input = gets.chomp

    if !input_valid? input, valid_input
      puts "invalid input, please try again"
    else
      return input
    end
  end
end


def show_stats cards
  puts "Cards: #{cards}"
  value = get_card_value cards
  puts "Card value: #{value}"
end

cards_player = []
cards_dealer = []

cards = new_deck

begin

  bet = get_valid_input "Place bet, please (number):", /^([1-9][0-9]*)$/

  puts "Your bet #{bet}"

  2.times { |card| cards_player.push get_card cards }
  puts "You"
  show_stats cards_player

  answer = get_valid_input "Hit or stay? (hit/stay):", /^hit$|^stay$/

  if 'hit' == answer
    cards_player.push get_card cards
  end

  puts "You"
  show_stats cards_player

  2.times { |card| cards_dealer.push get_card cards }

  puts "Dealer"
  show_stats cards_dealer

  value_player = get_card_value cards_player
  value_dealer = get_card_value cards_dealer


  puts "Do you want to quit (yes/no)?"
  quit = gets.chomp.downcase

end while quit != 'yes'

