require_relative 'board.rb'
require_relative 'input_validation.rb'
require_relative 'save_states.rb'

class Game
  include Validation
  include SaveStates
  attr_reader :board, :current_action

  def initialize(board = Board.new)
    @board = board
    @current_action = nil
  end

  def set_current_action(input)
    action = input == '1' ? :save : :guess
    @current_action = action
    puts @current_action.to_s
  end

  def game_over?
    board.remaining_guesses == 0 || board.goal_word.chars.all? { |char| board.correct_letters.include?(char) }
  end

  def start
    board.display
    # load_save unless new_game?
    until game_over?
      break if turn == false
    end
    calc_winner if game_over?
  end

  def calc_winner
    puts "#{board.remaining_guesses == 0 ? ">> You lose!" : ">> You win!"}"
    puts ">> The word was: #{board.goal_word}"
  end

  def new_game?
    puts ">> Press 1 for new game, 2 to load a previous save:"
    get_start_input == '1'
  end

  def correct_char_guess?(char)
    board.goal_word.include?(char)
  end

  def correct_word_guess(word)
    word == board.goal_word
  end

  def turn
    player_input = get_turn_input
    set_current_action(player_input)
    if current_action == :save
      save_current_game(board)
      return false
    elsif current_action == :guess
      #check if guess is word or character
      if player_input.length == 1
        board.remove_rem_letter(player_input)
        if correct_char_guess?(player_input)
          board.add_correct_letter(player_input)
        else
          board.remaining_guesses -= 1
        end
      else
        if correct_word_guess(player_input)
          player_input.chars.each { |char| board.add_correct_letter(char) unless board.correct_letters.include?(char) }
        else
          board.remaining_guesses -= 1
        end
      end
      board.display
    end
  end
  nil
end

Game.new.start