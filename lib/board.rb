require_relative 'dictionary.rb'

class Board
  attr_reader :goal_word
  attr_accessor :remaining_guesses, :remaining_letters, :correct_letters

  def initialize
    @goal_word = Dictionary.new.words.sample
    @remaining_guesses = 6
    @remaining_letters = ('a'..'z').to_a
    @correct_letters = []

    # testing
    # @goal_word = "hello"
    # @correct_letters = ["h", "e", "l", "o"]
  end

  def add_correct_letter(char)
    @correct_letters << char
  end

  def remove_rem_letter(char)
    @remaining_letters.delete(char)
  end

  def display_goal_word
    goal_word.chars.map { |char| correct_letters.include?(char) ? char : "_" }.join(" ")
  end

  def display
    puts ">> Available letters: #{remaining_letters.join(" ")}\n\n"
    puts ">> Remaining incorrect guesses: #{remaining_guesses}\n\n"
    puts ">> To guess: #{display_goal_word}"
  end
end