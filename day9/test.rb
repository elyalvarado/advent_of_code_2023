require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day9 < Minitest::Test
  REPORT =<<~DOC
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
  DOC

  def test_assert_next_1
    assert_equal 18, History.new('0 3 6 9 12 15').next
  end

  def test_assert_next_2
    assert_equal 28, History.new('1 3 6 10 15 21').next
  end

  def test_assert_next_3
    assert_equal 68, History.new('10 13 16 21 30 45').next
  end

  def test_sum_extrapolated
    assert_equal 114, History.sum_extrapolated(REPORT)
  end
end