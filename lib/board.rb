require_relative 'dictionary.rb'
require_relative 'color.rb'
require 'json'

class Board
  attr_reader :goal_word
  attr_accessor :rem_guesses, :correct_letters, :used_guesses

  def initialize(goal_word = Dictionary.new.words.sample, rem_guesses = 6, correct_letters = [], used_guesses = [])
    @goal_word = goal_word
    @rem_guesses = rem_guesses
    @correct_letters = correct_letters
    @used_guesses = used_guesses
  end

  def to_json
    {
      goal_word: @goal_word,
      rem_guesses: @rem_guesses,
      correct_letters: @correct_letters,
      used_guesses: @used_guesses
    }
  end

  def self.from_json(string)
    data = JSON.load(string)
    self.new(data["goal_word"], data["rem_guesses"], data["correct_letters"], data["used_guesses"])
  end

  def add_correct_letter(char)
    @correct_letters << char
  end

  def add_used_guess(char)
    @used_guesses << char
  end

  def display_goal_word
    goal_word.chars.map { |char| correct_letters.include?(char) ? char : "_" }.join(" ")
  end

  def display
    puts "#{">>".blue} Used letters: #{used_guesses.join(" ").magenta}\n\n"
    puts "#{">>".blue} Remaining incorrect guesses: #{rem_guesses.to_s.yellow}\n\n"
    puts "#{">>".blue} To guess: #{display_goal_word}"
  end
end