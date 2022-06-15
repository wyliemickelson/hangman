require_relative 'color.rb'
module GameText
  def goal_word_text
    ">> The word was: #{board.goal_word}"
  end

  def guess_text(is_correct)
    is_correct ? ">> Correct guess!".green : ">> Incorrect guess.".red
  end

  def end_text(is_winner)
    is_winner ? ">> You win!".green : ">> You lose!".red
  end

  def new_game_prompt
    ">> Press 1 for new game, 2 to load a previous save:"
  end

  def turn_prompt
    ">> Enter your letter guess or '1' to save and quit:"
  end

  def choose_save_prompt
    ">> Choose a save file by entering its number:"
  end

  def no_saves_text
    ">> No save files found. Starting new game."
  end

  def invalid_text
    ">> Invalid input."
  end

  def invalid_start_input_text
    ">> Invalid input. Enter a 1 or 2:"
  end

  def invalid_save_text
    ">> Invalid input. Enter a number corresponding to one of the saves."
  end
end