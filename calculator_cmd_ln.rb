# calculator for command line

def say (msg)
  puts "=> #{msg}"
end

def input_valid? (input, regexp)
  input =~ regexp ? true : false
end

puts "*** calculator started ***"

restart = ''

begin

  begin
    say "Enter first number:"
    num1 = gets.chomp
  end until input_valid? num1, /[0-9]/

  begin
    say "Enter second number:"
    num2 = gets.chomp
  end until input_valid? num2, /[0-9]/

  begin
    say "Select operation:"
    say "[1] add, [2] subtract, [3] multiply, [4] divide"
    operator = gets.chomp
  end until input_valid? operator, /^1$|^2$|^3$|^4$/


  result = case operator.to_i
    when 1 then num1.to_i + num2.to_i
    when 2 then num1.to_i - num2.to_i
    when 3 then num1.to_i * num2.to_i
    when 4 then num1.to_f / num2.to_f
    else "operator not valid!"
  end

  say "result: #{result}"

  begin
    say "Do you want to make another calculation? [Y/n]"
    restart = gets.chomp.downcase
    #"Y" is default, so check if user hits enter
    restart = "y" if restart == ""
  end until input_valid? restart, /^y$|^n$/

end while restart == "y"

say "Thank you, bye!"
