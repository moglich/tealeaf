#tic_tac_toe.rb

GRID_OBJECTS = { empty: "       ", vertial_rule: "|", x: "   X   ", o: "   O   ",
                horizontal_rule: "-------+-------+-------" }

EMPTY_LINE = GRID_OBJECTS[:empty] + GRID_OBJECTS[:vertial_rule] + GRID_OBJECTS[:empty]\
             + GRID_OBJECTS[:vertial_rule]

def show_grid (stats) #['', '', '', '', '', '', '', '', '']

  string = ''

  #each row
  3.times do |cnt|

    #each col
    3.times do |idx|

      case cnt
      when 1 then idx += cnt + 2
      when 2 then idx += cnt + 4
      end

      if stats[idx] == 'X'
        string << GRID_OBJECTS[:x]
      elsif stats[idx] == 'O'
        string << GRID_OBJECTS[:o]
      else
        string << GRID_OBJECTS[:empty]
      end

      if (idx == 2) or (idx == 5) or (idx == 8)
        puts EMPTY_LINE
        puts string
        puts EMPTY_LINE
        string = ''
      else
        string << GRID_OBJECTS[:vertial_rule]
      end
    end
    if cnt != 2
        puts GRID_OBJECTS[:horizontal_rule]
    end
  end
end


#reset game
board_stats = ['', '', '', '', '', '', '', '', '']
system "clear"
puts "Welcome to Tic Tac Toe!"
puts
show_grid (board_stats)
loop do
  puts "Choose a position (1-9) to place a cross:"
  
  begin
    user_choice = gets.chomp.to_i - 1
  end until board_stats[user_choice] == ''

  system "clear"

  board_stats[user_choice] = 'X'
  
  begin
    computer_choice = rand(9)
  end until board_stats[computer_choice] == ''
  board_stats[computer_choice] = 'O'

  show_grid (board_stats)

end