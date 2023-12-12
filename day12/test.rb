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

end