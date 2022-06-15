require "json"

module SaveStates

  @@saves = Dir.entries("saves").reject { |fname| fname == "." || fname == ".." }

  def save_current_game(board)
    self.save_game = true
    Dir.mkdir("saves") unless Dir.exists?("saves")
    time = Time.now
    save_fname =  time.strftime("%m-%d-%Y_%H-%M")
    File.open("saves/#{save_fname}.json", 'w') { |file| file.write(JSON.pretty_generate(board.to_json)) }
  end

  def load_save(pos)
    @board = Board.from_json(File.read("saves/#{@@saves[pos.to_i - 1]}"))
  end

  def display_saves
    @@saves.each_with_index { |save, index| puts "#{index + 1}: #{save}" }
  end

  def no_saves?
    @@saves.empty?
  end
end