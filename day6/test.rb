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
    assert_equal expected_races, Race.parse_races(RACES_DOC)
  end

  def test_beat_options
    assert_equal [2,3,4,5], Race.new(7, 9 ).beat_options
  end
end