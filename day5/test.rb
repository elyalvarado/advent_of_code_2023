require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day5 < Minitest::Test
  ALMANAC = <<~DOC
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
  DOC

  def test_map_range_parse
    assert_equal MapRange.new(destination_range_start: 1, source_range_start: 2, length: 3),
                 MapRange.parse("1 2 3")
  end

  def test_map_range_map_within
    map_range = MapRange.parse("50 98 2")
    assert_equal 50, map_range.map(98)
    assert_equal 51, map_range.map(99)
  end

  def test_map_range_map_under
    map_range = MapRange.parse("50 98 2")
    assert_nil map_range.map(97)
  end

  def test_map_range_map_over
    map_range = MapRange.parse("50 98 2")
    assert_nil map_range.map(100)
  end

  def test_map_range_map_hash
    map_range = MapRange.parse("50 98 2")
    expected = { 98 => 50, 99 => 51 }
    assert_equal expected, map_range.map_hash
  end

  def test_map_parse
    map_doc = <<~DOC
    seed-to-soil map:
    50 98 2
    DOC
    map_range = MapRange.new(destination_range_start: 50, source_range_start: 98, length: 2)
    assert_equal Map.new(source_category: "seed", destination_category: "soil", ranges: [map_range]),
                 Map.parse(map_doc)
  end

  def test_map_map
    map_doc = <<~DOC
      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15
    DOC

    map = Map.parse(map_doc)
    assert_equal 81, map.map(81)
    assert_equal 53, map.map(14)
    assert_equal 57, map.map(57)
    assert_equal 52, map.map(13)
  end

  def test_map_maps_hash
    map_doc = <<~DOC
      soil-to-fertilizer map:
      0 10 2
      2 12 2
    DOC
    map = Map.parse(map_doc)
    expected_hash = {
      10 => 0,
      11 => 1,
      12 => 2,
      13 => 3
    }
    assert_equal expected_hash, map.maps_hash
  end

  def test_almanac_parse
    almanac_doc = <<~DOC
      seeds: 1 2 3 4

      seed-to-soil map:
      0 0 3

      soil-to-fertilizer map:
      100 0 3

      fertilizer-to-location map:
      200 0 3
    DOC

    map_range_1 = MapRange.new(destination_range_start: 0, source_range_start: 0, length: 3)
    map_1 = Map.new(source_category: 'seed', destination_category: 'soil', ranges: [map_range_1])
    map_range_2 = MapRange.new(destination_range_start: 100, source_range_start: 0, length: 3)
    map_2 = Map.new(source_category: 'soil', destination_category: 'fertilizer', ranges: [map_range_2])
    map_range_3 = MapRange.new(destination_range_start: 200, source_range_start: 0, length: 3)
    map_3 = Map.new(source_category: 'fertilizer', destination_category: 'location', ranges: [map_range_3])
    assert_equal Almanac.new(original_sources: [1, 2, 3, 4], maps: [map_1, map_2, map_3]),
                 Almanac.parse(almanac_doc)
  end

  def test_min_final_destination
    almanac = Almanac.parse(ALMANAC)
    assert_equal 35, almanac.min_final_destination
  end

  def test_min_final_destination_for_ranges
    almanac = Almanac.parse(ALMANAC)
    assert_equal 46, almanac.min_final_destination_for_ranges
  end
end