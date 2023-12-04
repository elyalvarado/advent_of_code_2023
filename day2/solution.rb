class Game
  attr_reader :id
  def initialize game_string
    @game_string = game_string
  end

  def id
    @id ||= @game_string.split(":")[0].split(" ")[1].to_i
  end

end

if __FILE__ == $PROGRAM_NAME
end