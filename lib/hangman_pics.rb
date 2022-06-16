class HangmanPics
  attr_reader :HANGMANPICS

  def initialize
    @HANGMANPICS = [
      <<-DOC1,
      +---+
      |   |
          |
          |
          |
          |
    =========
      DOC1
      <<-DOC2,
      +---+
      |   |
      O   |
          |
          |
          |
    =========
      DOC2
      <<-DOC3,
      +---+
      |   |
      O   |
      |   |
          |
          |
    =========
    DOC3
    <<-DOC4,
      +---+
      |   |
      O   |
     /|   |
          |
          |
    =========
    DOC4
    <<-DOC5,
      +---+
      |   |
      O   |
     /|\\  |
          |
          |
    =========
    DOC5
    <<-DOC6,
      +---+
      |   |
      O   |
     /|\\  |
     /    |
          |
    =========
    DOC6
    <<-DOC7,
      +---+
      |   |
      O   |
     /|\\  |
     / \\  |
          |
    =========
    DOC7
  ]
  end
end