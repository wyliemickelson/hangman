module Validation

  def get_turn_input
    puts ">> Enter your letter guess or '1' to save:"
    loop do
      input = gets.chomp.downcase
      return input if valid_turn_input(input)
      puts ">> Invalid input."
    end
  end
  
  def get_start_input
    loop do
      input = gets.chomp
      return input if valid_start_input(input)
      puts ">> Invalid input. Enter a 1 or 2:"
    end
  end

  def valid_turn_input(input)
    input == '1' || board.remaining_letters.include?(input) || (board.goal_word.length == input.length && input.match(/\A[a-zA-Z]*\z/) )
  end

  def valid_start_input(input)
    input.between?('1', '2')
  end
end