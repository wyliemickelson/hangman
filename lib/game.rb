require_relative 'board.rb'
require_relative 'input_validation.rb'

class Game
  include Validation
  attr_reader :board, :current_action

  def initialize
    @board = Board.new
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
      turn
    end
    calc_winner
  end

  def calc_winner
    puts "#{board.remaining_guesses == 0 ? ">> You lose!" : ">> You win!"}"
    puts ">> The word was: #{board.goal_word}"
  end

  def new_game?
    puts ">> Press 1 for new game, 2 to load a previous save:"
    get_start_input == '1'
  end

  def correct_guess?(char)
    board.goal_word.include?(char)
  end

  def turn
    player_input = get_turn_input
    set_current_action(player_input)
    if current_action == :save
      #save the game
    elsif current_action == :guess
      board.remove_letter(player_input)
      if correct_guess?(player_input)
        board.add_correct_letter(player_input)
      else
        board.remaining_guesses -= 1
      end
      board.display
    end
  
  end
end

Game.new.start