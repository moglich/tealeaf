require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

ST_BUSTED = "Busted!"
ST_BLACKJACK = "Blackjack!"
LMT_DEALER_HIT = 17
LMT_BLACKJACK = 21

helpers do

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

    deck
  end

  def get_card(cards) #{:hearts => [{"2" => 2}, {"3" => 3}, {"4" => 4}], :spades => [{"2" => 2}, {"3" => 3}]}

    deck = cards.index(cards.sample)
    card_type = cards[deck].keys.sample
    card_value = cards[deck][card_type].sample

    cards[deck][card_type].delete(card_value)

    if cards[deck][card_type].empty?
      cards[deck].delete card_type
    end

    card = { card_type => card_value }
  end
  # >> {"2" => 2}


  def get_total(cards) #[{:hearts=>{"queen"=>10}}, {:spades=>{"7"=>7}}]
    value = 0
    ace_cnt = 0

    cards.each do |card_type|
      card_type.each_value do |card|
        card.each_value do |val|
          if val == 11
            ace_cnt += 1
          end
          value += val
        end
      end
    end

    while (value > LMT_BLACKJACK) && (ace_cnt > 0)
      value -= 10
      ace_cnt -= 1
    end

    value
  end

  def busted?(cards)
    get_total(cards) > LMT_BLACKJACK ? true : false
  end

  def blackjack?(cards)
    get_total(cards) == LMT_BLACKJACK ? true : false
  end

  def get_winner(cards_dealer, cards_player)

    value_player = get_total(cards_player)
    value_dealer = get_total(cards_dealer)

    if (value_player > LMT_BLACKJACK) && (value_dealer > LMT_BLACKJACK)
      winner = "none"
    elsif value_player > LMT_BLACKJACK
      winner = "Dealer"
    elsif value_dealer > LMT_BLACKJACK
      winner = "Player"
    elsif value_dealer == value_player
      winner = "push"
    elsif value_dealer < value_player
      winner = "Player"
    elsif value_dealer > value_player
      winner = "Dealer"
    end

    winner
  end
end

get '/' do
  if session[:username]
    redirect '/new_game'
  else
    redirect '/new_player'
  end
end

get '/logout' do
  session[:username] = nil
  redirect '/'
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  session[:username] = params[:username]
  redirect '/bet'
end

get '/bet' do
  if !session[:username]
    redirect '/new_player'
  end

  erb :bet
end

post '/bet' do
  session[:bet] = params[:bet]
  redirect '/new_game'
end

get '/new_game' do
  if !session[:username]
    redirect '/new_player'
  end

  session[:deck] = new_deck

  session[:dealer_cards] = []
  session[:player_cards] = []

  2.times do
    session[:dealer_cards] << get_card([session[:deck]])
    session[:player_cards] << get_card([session[:deck]])
  end

  if blackjack?(session[:player_cards])
    if blackjack?(session[:dealer_cards])
      session[:winner] = "push"
    else
      session[:winner] = "player"
    end
  end

  erb :game
end

get '/game' do
  if !session[:username]
    redirect '/new_player'
  end

  erb :game
end

post '/game/player/hit' do
  session[:player_cards] << get_card([session[:deck]])

  if busted?(session[:player_cards])
    @winner = "player"
    @stop_game = true
  end

  erb :game
end

get '/game/compare' do
  if blackjack?(session[:player_cards])
    @player_status = ST_BLACKJACK
  elsif busted?(session[:player_cards])
    @player_busted = ST_BUSTED
  end
  erb :game
end

post '/game/player/stay' do
  while session[:dealer_total] < LMT_DEALER_HIT
    session[:dealer_cards] << get_card([session[:deck]])
  end

  if busted?(session[:dealer_cards])
    session[:dealer_status] = ST_BUSTED
  end

  redirect '/game'
end
