require "json"

module SaveStates
  def save_current_game(board)
    Dir.mkdir("saves") unless Dir.exists?("saves")
    time = Time.now
    save_fname =  time.strftime("%m-%d-%Y_%H-%M")
    File.open("saves/#{save_fname}.json", 'w') { |file| file.write(JSON.pretty_generate(board.to_json)) }
  end

  def load_game(game)

  end
end