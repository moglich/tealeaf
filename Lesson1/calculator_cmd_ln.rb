# calculator for command line


def say (msg)
  puts "=> #{msg}"
end

def input_valid? (input, regexp)
  input =~ regexp ? true : false
end

def get_answer (question, valid_input, &block)
  begin
    say question
    input = block.call
  end until input_valid? input, valid_input

  return input
end

puts "*** calculator started ***"

restart = 'y'

begin

  num1 = get_answer "Enter first number:", /[0-9]/ do
    gets.chomp
  end

  num2 = get_answer "Enter second number:", /[0-9]/ do
    gets.chomp
  end

  operator = get_answer "Select operation:", /^1$|^2$|^3$|^4$/ do
    say "[1] add, [2] subtract, [3] multiply, [4] divide"
    gets.chomp
  end

  result = case operator.to_i
    when 1 then num1.to_i + num2.to_i
    when 2 then num1.to_i - num2.to_i
    when 3 then num1.to_i * num2.to_i
    when 4 then if num2.to_f == 0
                  say "division by 0 not possible!"
                else
                  num1.to_f / num2.to_f
                end
    else "operator not valid!"
  end

  #print out result and make some space 
  say "result: #{result}\n\n\n\n"

  restart = get_answer "Do you want to make another calculation? [Y/n]", /^y$|^n$/ do
    input = gets.chomp.downcase
    #"Y" is default, so check if user hits enter
    if input == ""
      answer = "y"
    else
      answer = input
    end
  end

end while restart == "y"

say "Thank you, bye!"
