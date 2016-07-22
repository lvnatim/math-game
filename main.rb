require 'colorize'
require 'pry-byebug'
require_relative './game_data'
require_relative './game_methods'

begin

  puts "It is turn #{turn_counter}".white
  puts "It is #{print_name}'s turn!".white

  print generate_question.white
  answer = gets.strip.to_i

  if check_answers(answer)
    correct_response
    next_turn
  else
    #binding.pry
    incorrect_response
    out_of_lives? ? game_over_play_again : next_turn
  end

end while @game_data[:game_over] == false

puts "----------------------------------GAME-OVER----------------------------------".white
