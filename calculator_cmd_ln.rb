# calculator for command line

def say (msg)
  puts "=> #{msg}"
end

puts "*** calculator started ***"

say "Enter first number:"
num1 = gets.chomp

say "Enter second number:"
num2 = gets.chomp

say "Select operation:"
say "[1] add, [2] subtract, [3] multiply, [4] divide"

operation = gets.chomp

result = case operation.to_i
  when 1 then num1.to_i + num2.to_i
  when 2 then num1.to_i - num2.to_i
  when 3 then num1.to_i * num2.to_i
  when 4 then num1.to_f / num2.to_f
  else "operator not valid!"
end

say "result: #{result}"
say "Thank you, bye!"