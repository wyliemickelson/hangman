require_relative 'game_text.rb'

module Validation
  include GameText

  def get_turn_input
    puts turn_prompt
    loop do
      input = gets.chomp.downcase
      return input if valid_turn_input(input)
      puts invalid_text
    end
  end

  def valid_turn_input(input)
    input == '1' || board.rem_letters.include?(input) || (board.goal_word.length == input.length && input.match(/\A[a-zA-Z]*\z/) )
  end
  
  def get_start_input
    loop do
      input = gets.chomp
      return input if ['1', '2'].include?(input)
      puts invalid_start_input_text
    end
  end

  def get_save_pos
    puts choose_save_prompt
    loop do
      input = gets.chomp
      return input if input.to_i.between?(1, Dir.entries("saves").length - 2)
      puts invalid_save_text
    end
  end
end