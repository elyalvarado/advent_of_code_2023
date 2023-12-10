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

  def test_assert_next_4
    assert_equal 16489171, History.new('-6 -13 -17 3 93 334 845 1783 3355 5876 9945 16889 29783 55659 110077 226237 472643 986772 2038810 4152178 8331240').next
  end

  def test_sum_extrapolated
    assert_equal 114, History.sum_extrapolated(REPORT)
  end

  def test_assert_next_backwards_1
    assert_equal -3, HistoryBackwards.new('0 3 6 9 12 15').next
  end

  def test_assert_next_backwards_2
    assert_equal 0, HistoryBackwards.new('1 3 6 10 15 21').next
  end

  def test_assert_next_backwards_3
    assert_equal 5, HistoryBackwards.new('10 13 16 21 30 45').next
  end

  def test_sum_extrapolate_backwards
    assert_equal 2, HistoryBackwards.sum_extrapolated(REPORT)
  end
end