require_relative "board.rb"
require_relative "input_validation.rb"
require_relative "save_states.rb"
require_relative "game_text.rb"

class Game
  include Validation
  include SaveStates
  include GameText

  attr_accessor :board, :save_game, :win, :save_file

  def initialize
    @board = Board.new
    @save_game = false
    @win = false
    @save_file = nil
  end

  def loss
    board.rem_guesses == 0
  end

  def load_game
    clear
    if no_saves?
      puts no_saves_text
    else
      display_saves
      @save_file = load_save(get_save_pos)
      clear
    end
  end

  def start
    clear
    load_game unless new_game?
    until win || loss || save_game
      board.display
      turn
    end
    unless save_game
      calc_winner
      del_save(save_file)
    end
  end

  def calc_winner
    puts board.display unless win
    puts end_text(win)
    puts goal_word_text
  end

  def new_game?
    puts new_game_prompt
    get_start_input == "1"
  end

  def correct_guess?(guess)
    guess.length == 1 ? board.goal_word.include?(guess) : guess == board.goal_word
  end

  def update_board(guess)
    is_correct = correct_guess?(guess)
    if is_correct && guess.length == 1
      board.add_correct_letter(guess)
      self.win = true if board.goal_word.chars.all? { |char| board.correct_letters.include?(char) }
    elsif is_correct
      self.win = true
    else
      board.rem_guesses -= 1
    end
    board.add_used_guess(guess)
    clear
    puts guess_text(is_correct)
  end

  def turn
    p_input = get_turn_input
    action = (p_input == "1" ? :save : :guess)
    action == :save ? save_current_game(board, get_save_name) : update_board(p_input)
  end
end
