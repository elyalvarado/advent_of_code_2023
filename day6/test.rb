require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day6 < Minitest::Test
  RACES_DOC =<<~DOC
    Time:      7  15   30
    Distance:  9  40  200
  DOC

  def test_parse_races
    expected_races = [
      Race.new(7,9),
      Race.new(15,40),
      Race.new(30, 200)
    ]
    assert_equal expected_races, RaceCollection.new(RACES_DOC).races
  end

  def test_beat_options
    assert_equal [2,3,4,5], Race.new(7, 9 ).beat_options
  end

  def test_beat_options_sizes
    # assert_equal 4, Race.new(7,9).beat_options.size
    # assert_equal 8, Race.new(15,40).beat_options.size
    assert_equal 9, Race.new(30, 200).beat_options.size
  end

  def test_total_options
    assert_equal 288, RaceCollection.new(RACES_DOC).total_options
  end
end