#tic_tac_toe.rb

def show_grid (board) #['', '', '', '', '', '', '', '', '']
  system 'clear'
  puts "----  Tic Tac Toe  ----"
  puts
  puts "       |       |"
  puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}"
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}"
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}"
  puts "       |       |"
end

def empty_positions(board)
  board.keys.select {|position| board[position] == ' '}
end

def pick_cell_user(board)
  begin
    puts "Choose a position (1-9) to place a cross:"
    position = gets.chomp.to_i
  end until empty_positions(board).include?(position)
  board[position] = 'X'
end

def pick_cell_computer (board)
  begin
    computer_choice = empty_positions(board).sample
  end until empty_positions(board).include?(computer_choice)
  board[computer_choice] = 'O'

end

def get_winner(board)
  solution_combos = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  solution_combos.each do |combo|
    return "user" if board.values_at(*combo).count('X') == 3
    return "computer" if board.values_at(*combo).count('O') == 3
  end
  return nil
end

#reset game
board_stats = {}
(1..9).each {|position| board_stats[position] = ' ' }


show_grid (board_stats)

loop do

  pick_cell_user(board_stats)
  show_grid (board_stats)

  winner = get_winner(board_stats)
  
  if winner
    puts "#{winner} won the game!"
    exit
  end

  pick_cell_computer(board_stats)
  show_grid (board_stats)

  winner = get_winner(board_stats)
  if winner
    puts "#{winner} won the game!"
    exit
  end

end
