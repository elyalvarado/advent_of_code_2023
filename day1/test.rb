require 'minitest/autorun'
require_relative 'part1'  # Replace with the actual path

class Day1 < Minitest::Test
  def test_calibration_value
    assert_equal 12, calibration_value('1abc2')
    assert_equal 38, calibration_value('pqr3stu8vwx')
    assert_equal 15, calibration_value('a1b2c3d4e5f')
    assert_equal 77, calibration_value('treb7uchet')
  end

  def test_sum_calibration_doc
    calibration_doc = <<-DOC
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    DOC
    assert_equal 142, sum_calibration_doc(calibration_doc)
  end
end