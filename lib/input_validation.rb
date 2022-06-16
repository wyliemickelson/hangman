require_relative "game_text.rb"

module Validation
  include GameText

  def get_turn_input
    puts turn_prompt
    loop do
      input = gets.chomp.downcase
      return input if valid_turn_input(input)
      output = invalid_text
      if board.used_guesses.include?(input)
        output = already_guessed_text
      elsif ![1, board.goal_word.length].include?(input.length)
        output = invalid_guess_size_text
      end
      puts output
    end
  end

  def valid_turn_input(input)
    return true if input == "1"
    return false if input !~ /\A[a-zA-Z]*\z/
    return false if board.used_guesses.include?(input)
    [1, board.goal_word.length].include?(input.length)
  end

  def get_start_input
    loop do
      input = gets.chomp
      return input if ["1", "2"].include?(input)
      puts invalid_start_input_text
    end
  end

  def get_save_name
    if save_file.nil?
      puts enter_save_name_prompt
      loop do
        fname = gets.chomp
        return fname if fname !~ /[^a-z^A-Z^0-9^_^-]/
        puts invalid_fname_text
      end
    else
      save_file
    end
  end

  def get_save_pos
    puts choose_save_prompt
    loop do
      input = gets.chomp.to_i
      return input if input.between?(1, Dir.entries("saves").length - 2)
      puts invalid_save_text
    end
  end
end
