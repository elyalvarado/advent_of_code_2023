require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day12 < Minitest::Test
  SPRINGSMAP = <<~DOC
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
  DOC

  def test_spring_arrangements_1
    assert_equal 1, Spring.new('???.### 1,1,3').arrangements
  end

  def test_spring_arrangements_2
    assert_equal 4, Spring.new('.??..??...?##. 1,1,3').arrangements
  end

  def test_spring_arrangement_3
    assert_equal 1, Spring.new('?#?#?#?#?#?#?#? 1,3,1,6').arrangements
  end

  def test_spring_arrangement_4
    assert_equal 1, Spring.new('????.#...#... 4,1,1').arrangements
  end

  def test_spring_arrangement_5
    assert_equal 4, Spring.new('????.######..#####. 1,6,5').arrangements
  end

  def test_spring_arrangement_6
    assert_equal 10, Spring.new('?###???????? 3,2,1').arrangements
  end

  def test_spring_map_arrangements
    assert_equal 21, SpringsMap.new(SPRINGSMAP).arrangements
  end
end