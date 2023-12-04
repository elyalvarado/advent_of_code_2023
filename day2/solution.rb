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
      CubeSet.new(set_string)
    end
  end

  def min_set
    CubeSet.min_set(sets)
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
end

class CubeSet
  include Enumerable
  def initialize(set_string_or_hash)
    @set = set_string_or_hash.is_a?(Hash) ? set_string_or_hash : parse(set_string_or_hash)
  end

  def [](key)
    @set[key]
  end

  def to_h
    @set
  end

  def each
    @set.each do |x, y|
      yield x, y
    end
  end

  def power
    @set.inject(1) do |power, keys|
      power * keys[1]
    end
  end

  def self.min_set(sets)
    maxs = {}
    sets.each do |cube_set|
      cube_set.each do |color, value|
        maxs[color] = value unless maxs[color]
        maxs[color] = value if value > maxs[color]
      end
    end
    CubeSet.new(maxs)
  end

  private
  def parse set_string
    set = {}
    set_string.split(",").each do |cube_string|
      number, color = cube_string.split(" ")
      set[color.to_sym] = number.to_i
    end
    set
  end
end

if __FILE__ == $PROGRAM_NAME
  total_set = { red: 12, green: 13, blue: 14 }
  puts Game.valid_games_sum(File.readlines("input.txt"), CubeSet.new(total_set))
end