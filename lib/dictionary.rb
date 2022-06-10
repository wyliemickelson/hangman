require 'open-uri'

class Dictionary
  def initialize(shortest = 5, longest = 12)
    @words = retrieve_default_words.select { |word| word.length.between?(shortest, longest) }
  end
end

def retrieve_default_words
  fname = "../word_dict.txt"
  unless File.file?(fname)
    server_file = URI.open("https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt")
    File.open("../word_dict.txt", "w") { |file| file.write(server_file.read) }
  end
  File.open(fname, "r") { |file| file.readlines(chomp: true) }
end