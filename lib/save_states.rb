require "json"

module SaveStates
  @@saves = Dir.exists?("saves") ? Dir.entries("saves").reject { |fname| fname == "." || fname == ".." } : []

  def save_current_game(board, fname)
    self.save_game = true
    Dir.mkdir("saves") unless Dir.exists?("saves")
    fname = "#{fname}.json" unless fname.include?(".json")
    File.open("saves/#{fname}", "w") { |file| file.write(JSON.pretty_generate(board.to_json)) }
  end

  def load_save(pos)
    @board = Board.from_json(File.read("saves/#{@@saves[pos - 1]}"))
    @@saves[pos - 1]
  end

  def del_save(fname)
    File.delete("saves/#{fname}") if File.file?("saves/#{fname}")
  end

  def display_saves
    @@saves.each_with_index { |save, index| puts "#{index + 1}: #{save}".chomp(".json") }
  end

  def no_saves?
    @@saves.empty?
  end
end
