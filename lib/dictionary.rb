require 'open-uri'

class Dictionary
  attr_reader :words

  def initialize(shortest = 5, longest = 12)
    @words = retrieve_default_words.select { |word| word.length.between?(shortest, longest) }
  end
end

def retrieve_default_words
  url = "https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt"
  URI.open(url) { |file| file.readlines(chomp: true) }
end