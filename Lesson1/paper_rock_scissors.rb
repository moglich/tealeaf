#paper_rock_scissors.rb

ITEMS = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}

def show_win_msg(user_item)
  case user_item
  when 'p'
    puts "Paper wraps Rock"
  when 'r'
    puts "Rock smashes Scissors"
  when 's'
    puts "Scissors cuts Paper"
  end
end

loop do

  #clear screen first
  system "clear"
  puts "---Play Paper Rock Scissors!---"

  begin
  puts "Choose one: (p/r/s)"
    user_item = gets.chomp.downcase
  end until ITEMS.keys.include?(user_item)

  computer_item = ITEMS.keys.sample

  if user_item == computer_item
    puts "It's a tie!"
  elsif (user_item == 'p' and computer_item == 'r') or (user_item == 'r' and computer_item == 's')\
         or (user_item == 's' and computer_item == 'p')
    show_win_msg(user_item)
    puts "You won!"
  else
    show_win_msg(computer_item)
    puts "Computer won!"
  end

  #Replay?
  begin
    puts"Do you want to play again? [Y/n]"
    input = gets.chomp.downcase
    #"Y" is default, so check if user hits enter
    if input == ""
      replay = 'y'
    else
      replay = input
    end
  end until (replay == 'y') or (replay == 'n')

  break if replay == 'n'
end

puts "Thank you, bye!"