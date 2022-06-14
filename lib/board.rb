require_relative 'dictionary.rb'
require 'json'

class Board
  attr_reader :goal_word
  attr_accessor :rem_guesses, :rem_letters, :correct_letters

  def initialize(goal_word = Dictionary.new.words.sample, rem_guesses = 6, rem_letters = ('a'..'z').to_a, correct_letters = [])
    @goal_word = goal_word
    @rem_guesses = rem_guesses
    @rem_letters = rem_letters
    @correct_letters = correct_letters
  end

  def to_json
    {
      goal_word: @goal_word,
      rem_guesses: @rem_guesses,
      rem_letters: @rem_letters,
      correct_letters: @correct_letters
    }
  end

  def self.from_json(string)
    data = JSON.load(string)
    self.new(data["goal_word"], data["rem_guesses"], data["rem_letters"], data["correct_letters"])
  end

  def add_correct_letter(char)
    @correct_letters << char
  end

  def remove_rem_letter(char)
    @rem_letters.delete(char)
  end

  def display_goal_word
    goal_word.chars.map { |char| correct_letters.include?(char) ? char : "_" }.join(" ")
  end

  def display
    puts ">> Available letters: #{rem_letters.join(" ")}\n\n"
    puts ">> Remaining incorrect guesses: #{rem_guesses}\n\n"
    puts ">> To guess: #{display_goal_word}"
  end
end