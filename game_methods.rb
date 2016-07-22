require './game_data'

# Because banners look cool
def intro_banner
  puts "|----------------------------------------------------------------------------|".white
  puts "|                                                                            |".white
  puts "|                               HOW TO MATH?                                 |".white
  puts "|                                                                            |".white
  puts "|----------------------------------------------------------------------------|".white
end

# Asks for user name input and generates name string
def get_name_player(num)
  print "Enter name for player #{num}: ".white
  return gets.strip
end

# THIS RUNS BEFORE AFTER INITIALIZING GAME DATA. It loads two user-inputted player names
intro_banner
puts " "
@game_data[:player_1][:name] = get_name_player(1)
@game_data[:player_2][:name] = get_name_player(2)
puts " "

# When invoked, adds 1 to turn counter and returns turn counter
def turn_counter
  @game_data[:turn_counter] += 1
end

# Returns current player's data
def check_current_player
  @game_data[@game_data[:player_turn]]
end

# Switches current player to the other player and returns data as well
def switch_player
  if @game_data[:player_turn] == :player_1
    @game_data[:player_turn] = :player_2
    return @game_data[:player_2]
  else
    @game_data[:player_turn] = :player_1
    return @game_data[:player_1]
  end
end

# Prints name of current player
def print_name
  check_current_player[:name]
end

# Generates array of two random numbers
def generate_numbers
  number_1 = Random.new.rand(20)
  number_2 = Random.new.rand(20)
  sym = [:+, :-, :*]
  random_sym = sym.sample
  return [number_1, random_sym, number_2]
end

# Generates string of the answer
def generate_question_string(arr)
  return "What is #{arr[0]} plus #{arr[1]}? : "
end

def generate_question
  numgen_arr = generate_numbers
  @game_data[:current_answer] = numgen_arr[0].send(numgen_arr[1], numgen_arr[2])
  return "What is #{numgen_arr[0]} #{numgen_arr[1]} #{numgen_arr[2]}? : "
end

# Returns true if answer is correct, false if incorrect
def check_answers(user_answer)
  if user_answer == @game_data[:current_answer]
    true
  else
    false
  end
end

# Generates the correct answer response and switches player
def correct_response
  puts "Correct! Next turn!".green
  puts "#{print_name} now has #{calculate_points} points!"
end

# Generates the incorrect answer response and checks loss condition.
def incorrect_response
  puts "Incorrect!".red
  puts "The correct answer was #{@game_data[:current_answer]}".red
  lives_left = check_current_player[:lives] -= 1
  puts "#{print_name} has #{lives_left} lives left.".red
end

# Readies data for next turn
def next_turn
  switch_player
  print_turn_break
end

#Generates the game over/play again response.
def game_over_play_again
  puts "#{print_name} loses with #{check_current_player[:points]} points!".red
  winner = switch_player
  puts "#{winner[:name]} wins with #{winner[:points]} points!".green
  play_again? ? reset_game : game_over
end

# Adds a point for a correct answer and returns total points
def calculate_points
  check_current_player[:points] += 1
end

# Returns true if current player is out of lives
def out_of_lives?
  check_current_player[:lives] == 0 ? true : false
end

# Returns true if user input is Y (for YES)
def play_again?
  print "Would you like to play again? (Y for YES) "
  response = gets.strip.upcase
  response == 'Y' ? true : false
end

# Resets all data in game except for names.
def reset_game
  stored_name_1 = @game_data[:player_1][:name]
  stored_name_2 = @game_data[:player_2][:name]
  @game_data = {
    player_1: {
      lives: 3,
      name: stored_name_1,
      points: 0
    },
    player_2: {
      lives: 3,
      name: stored_name_2,
      points: 0
    },
    player_turn: "player_1".to_sym,
    turn_counter: 0,
    game_over: false
  }
  puts " "
  puts "----------------------------------NEW-GAME----------------------------------".white
  puts " "
end

# Invoked when turn is over.
def print_turn_break
  puts " "
end

# Ends game after loop.
def game_over
  @game_data[:game_over] = true
end
