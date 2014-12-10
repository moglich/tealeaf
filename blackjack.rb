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
    (2..10).each do |value|
      deck[card_type] << { value.to_s => value }
    end
    deck[card_type] << { "jack"  => 10 }
    deck[card_type] << { "queen" => 10 }
    deck[card_type] << { "king"  => 10 }
    deck[card_type] << { "ace"   => 11 }
  end

  return deck
end


def get_card (cards) #{:hearts => [{"2" => 2}, {"3" => 3}, {"4" => 4}], :spades => [{"2" => 2}, {"3" => 3}]}

  if cards.count == 0
    puts "No more cards left!"
    exit
  end

  card_type = cards.keys.sample
  card_value = cards[card_type].sample

  cards[card_type].delete card_value

  if cards[card_type].empty?
    cards.delete card_type
  end

  card = { card_type => card_value }

  return card
end
# >> {"2" => 2}


def get_card_value cards #[{:hearts=>{"queen"=>10}}, {:spades=>{"7"=>7}}]
  value = 0
  cards.each do |card_type|
    card_type.each_value do |card|
      card.each_value { |val| value += val }
    end
  end
  return value
end


def get_valid_input (statement, valid_input)
  loop do
    puts
    puts statement
    input = gets.chomp

    if !input_valid? input, valid_input
      puts "invalid input, please try again"
    else
      return input
    end
  end
end


def get_bet
  bet = get_valid_input "Place bet, please (number):", /^([1-9][0-9]*)$/
  puts "Your bet #{bet}"

  return bet.to_i
end


def hit_again?
  answer = get_valid_input "Hit or stay? (h/s):", /^h$|^s$/
  answer == 'h' ? true : false
end


def blackjack? cards
  21 == (get_card_value cards) ? true : false
end

def get_winner cards_dealer, cards_player

  value_player = get_card_value cards_player
  value_dealer = get_card_value cards_dealer

  if (value_player > 21) && (value_dealer > 21)
    winner = "none"
  elsif value_player > 21
    winner = "Dealer"
  elsif value_dealer > 21
    winner = "Player"
  elsif value_dealer == value_player
    winner = "push"
  elsif value_dealer < value_player
    winner = "Player"
  elsif value_dealer > value_player
    winner = "Dealer"
  end

  return winner
end


def show_stats user, cards
  puts
  puts "#{user}: #{cards}"
  value = get_card_value cards
  puts "Card value: #{value}"
end


def show_table cards_dealer, cards_player, bet_player
  system 'clear'
  puts "+++ Blackjack +++"
  puts
  puts "Your bet #{bet_player}"
  show_stats "Dealer", cards_dealer
  show_stats "You", cards_player
end

cards = new_deck

begin

  cards_player = []
  cards_dealer = []

  system 'clear'
  puts "Welcome to Blackjack (shoe game)"

  bet_player = get_bet

  2.times { |card| cards_player.push get_card cards }
  2.times { |card| cards_dealer.push get_card cards }
  
  show_table cards_dealer, cards_player, bet_player

  if blackjack? cards_player
    puts "Blackjack! You won!"
  end

  while hit_again?
    cards_player.push get_card cards
    show_table cards_dealer, cards_player, bet_player

    if (get_card_value cards_player) >= 21
      break
    end
  end

  while (get_card_value cards_dealer) <= 17
    cards_dealer.push get_card cards
    show_table cards_dealer, cards_player, bet_player
  end

  winner = get_winner cards_dealer, cards_player

  if winner == "Player"
    puts "You won #{bet_player * 2} dollars!"
  elsif winner == "none"
    puts "no winner"
  elsif winner == "push"
    puts "It's a push"
  else
    puts "You lost #{bet_player} dollars!"
  end

  puts "Do you want to play again [Y/n]?"
  play_again = gets.chomp.downcase

end while play_again != 'n'
