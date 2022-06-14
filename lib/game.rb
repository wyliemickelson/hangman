require_relative "board.rb"
require_relative "input_validation.rb"
require_relative "save_states.rb"
require_relative "game_text.rb"

class Game
  include Validation
  include SaveStates
  include GameText

  attr_reader :current_action
  attr_accessor :board

  def initialize
    @board = Board.new
    @current_action = nil
  end

  def set_current_action(input)
    action = (input == "1" ? :save : :guess)
    @current_action = action
  end

  def game_over?
    board.rem_guesses == 0 || board.goal_word.chars.all? { |char| board.correct_letters.include?(char) }
  end

  def start
    unless new_game?
      if no_saves?
        puts no_saves_text
      else
        display_saves
        pos = get_save_pos
        load_save(pos)
      end
    end
    until game_over?
      board.display
      break if turn == false
    end
    calc_winner if game_over?
  end

  def calc_winner
    puts "#{board.rem_guesses == 0 ? ">> You lose!" : ">> You win!"}"
    puts goal_word_text
  end

  def new_game?
    puts new_game_prompt
    get_start_input == "1"
  end

  def correct_char_guess?(char)
    board.goal_word.include?(char)
  end

  def correct_word_guess(word)
    word == board.goal_word
  end

  def char_guess(player_input)
    board.remove_rem_letter(player_input)
    if correct_char_guess?(player_input)
      board.add_correct_letter(player_input)
    else
      board.rem_guesses -= 1
    end
  end

  def word_guess(player_input)
    if correct_word_guess(player_input)
      player_input.chars.each { |char| board.add_correct_letter(char) unless board.correct_letters.include?(char) }
    else
      board.rem_guesses -= 1
    end
  end

  def turn
    player_input = get_turn_input
    set_current_action(player_input)
    if current_action == :save
      save_current_game(board)
      return false
    elsif current_action == :guess
      case guess_type = (player_input.length == 1 ? :char : :word)
      when :char
        char_guess(player_input)
      when :word
        word_guess(player_input)
      end
    end
  end
end

Game.new.start
