class Almanac
  attr_accessor :original_sources, :maps

  def initialize(original_sources:, maps:)
    @original_sources = original_sources
    @maps = maps
  end

  def self.parse(doc)
    parts = doc.split("\n\n")
    first_part = parts.shift
    original_sources = first_part.split(": ")[1].split(" ").map(&:to_i)
    maps = parts.map { |part| Map.parse(part) }
    self.new(original_sources: original_sources, maps: maps)
  end

  def final_destinations
    original_sources.map do |source|
      destination_for(source)
    end
  end

  def ==(another)
    self.original_sources == another.original_sources && self.maps == another.maps
  end

  private
  def destination_for(source)
    current_source = source
    current_destination = nil
    maps.size.times do |i|
      current_destination = maps[i].map(current_source)
      current_source = current_destination
    end
    current_destination
  end
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

  def map(source)
    destination = ranges.inject(nil) do |current_destination, range|
      if current_destination.nil?
        current_destination = range.map(source)
      end
      current_destination
    end
    return source if destination.nil?
    destination
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
  almanac_doc = File.read("input.txt")
  almanac = Almanac.parse(almanac_doc)
  puts almanac.final_destinations.min
end