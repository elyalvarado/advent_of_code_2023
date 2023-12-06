class Almanac

end

class Map
  attr_reader :source_category, :destination_category, :ranges

end

class MapRange
  attr_reader :destination_range_start, :source_range_start, :length
  def initialize(destination_range_start:, source_range_start:, length:)
    @destination_range_start = destination_range_start
    @source_range_start = source_range_start
    @length = length
  end

  def map(source)
    return nil if source < source_range_start
    return nil if source > source_range_end
    delta = source - source_range_start
    destination_range_start + delta
  end

  def self.parse(doc)
    destination_range_start, source_range_start, length = doc.split(" ").map(&:to_i)
    self.new(destination_range_start: destination_range_start, source_range_start: source_range_start, length: length)
  end

  def ==(another)
    self.destination_range_start == another.destination_range_start &&
      self.source_range_start == another.source_range_start &&
      self.length == another.length
  end

  private
  def destination_range_end
    destination_range_start + length - 1
  end

  def source_range_end
    source_range_start + length - 1
  end
end

if __FILE__ == $PROGRAM_NAME

end