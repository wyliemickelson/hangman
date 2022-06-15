require_relative 'color.rb'
module GameText

  def output
    ">>".yellow
  end

  def clear
    if Gem.win_platform?
      system "cls"
    else
      system "clear"
    end
  end

  def goal_word_text
    "#{output} The word was: #{board.goal_word.cyan}"
  end

  def guess_text(is_correct)
    is_correct ? "#{output} #{"Correct guess!".green}" : "#{output} #{"Incorrect guess.".red}"
  end

  def end_text(is_winner)
    is_winner ? "#{output} #{"Congratulations, you win!".green}" : "#{output} #{"Sorry, you lose!".red}"
  end

  def new_game_prompt
    "#{output} Press #{"1".magenta} for new game, #{"2".magenta} to load a previous save:"
  end

  def turn_prompt
    "#{output} Enter your letter guess or '1' to save and quit:"
  end

  def choose_save_prompt
    "#{output} Choose a save file by entering its number:"
  end

  def no_saves_text
    "#{output} #{"No save files found.".red} Starting new game."
  end

  def invalid_text
    "#{output} #{"Invalid input.".red}"
  end

  def invalid_start_input_text
    "#{output} #{invalid_text} Enter a #{"1".magenta} or #{"2".magenta}:"
  end

  def invalid_save_text
    "#{output} #{invalid_text} Enter a number corresponding to one of the saves."
  end
end