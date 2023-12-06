class Almanac

end

class Map
  attr_reader :source_category, :destination_category, :ranges
  def initialize(source_category:, destination_category:, ranges: [])
    @source_category = source_category
    @destination_category = destination_category
    @ranges = ranges
  end

  def self.parse(doc)
    lines = doc.split("\n")
    first_line = lines.shift
    source_category, destination_category = first_line.split(" ")[0].split("-to-")
    ranges = lines.map { |line| MapRange.parse(line) }
    self.new(source_category: source_category, destination_category: destination_category, ranges: ranges)
  end

  def ==(another)
    self.source_category == another.source_category &&
      self.destination_category == another.destination_category &&
      self.ranges.sort == another.ranges.sort
  end
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