class Game
  attr_reader :id
  def initialize game_string
    @game_string = game_string
  end

  def id
    @id ||= @game_string.split(":")[0].split(" ")[1].to_i
  end

  def sets
    @sets ||= @game_string.split(":")[1].split(";").map do |set_string|
      parse_set set_string
    end
  end

  def is_valid?(total_set)
    self.sets.each do |set|
      total_set.each do |color, quantity|
        next unless set[color]
        return false if set[color] > quantity
      end
    end
    true
  end

  def self.valid_games_sum(lines, total_set)
    lines
      .map { |line| Game.new(line) }
      .select { |game| game.is_valid?(total_set) }
      .map { |game| game.id }
      .inject(&:+)
  end

  private
  def parse_set set_string
    set = {}
    set_string.split(",").each do |cube_string|
      number, color = cube_string.split(" ")
      set[color.to_sym] = number.to_i
    end
    set
  end

end


if __FILE__ == $PROGRAM_NAME
end