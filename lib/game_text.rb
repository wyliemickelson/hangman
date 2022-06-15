require_relative 'color.rb'
module GameText
  def goal_word_text
    ">> The word was: #{board.goal_word.cyan}"
  end

  def guess_text(is_correct)
    is_correct ? ">> Correct guess!".green : ">> Incorrect guess.".red
  end

  def end_text(is_winner)
    is_winner ? ">> Congratulations, you win!".green : ">> Sorry, you lose!".red
  end

  def new_game_prompt
    ">> Press #{"1".magenta} for new game, #{"2".magenta} to load a previous save:"
  end

  def turn_prompt
    ">> Enter your letter guess or '1' to save and quit:"
  end

  def choose_save_prompt
    ">> Choose a save file by entering its number:"
  end

  def no_saves_text
    ">> #{"No save files found.".red} Starting new game."
  end

  def invalid_text
    ">> #{"Invalid input.".red}"
  end

  def invalid_start_input_text
    ">> #{invalid_text} Enter a #{"1".magenta} or #{"2".magenta}:"
  end

  def invalid_save_text
    ">> #{invalid_text} Enter a number corresponding to one of the saves."
  end
end