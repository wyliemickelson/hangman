require_relative 'board.rb'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def game_over?
    board.remaining_guesses == 0 || board.goal_word.chars.all? { |char| board.correct_letters.include?(char) }
  end

  def start
    board.display
    until game_over?
      turn
    end
    if board.remaining_guesses == 0
      puts ">> You lose!"
    else
      puts ">> You win!"
    end
    puts ">> The word was: #{board.goal_word}"
  end

  def valid_char(char)
    board.remaining_letters.include?(char)
  end

  def get_guess
    puts ">> Enter your letter guess: "
    guess = gets.chomp.downcase
    until valid_char(guess)
      puts "Invalid input."
      guess = gets.chomp.downcase
    end
    guess
  end

  def correct_guess?(char)
    board.goal_word.include?(char)
  end

  def turn
    player_input = get_guess
    board.remove_letter(player_input)
    if correct_guess?(player_input)
      board.add_correct_letter(player_input)
    else
      board.remaining_guesses -= 1
    end
    board.display
  end
end

Game.new.start