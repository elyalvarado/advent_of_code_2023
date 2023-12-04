require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day1 < Minitest::Test
  def test_calibration_value
    assert_equal 12, calibration_value('1abc2')
    assert_equal 38, calibration_value('pqr3stu8vwx')
    assert_equal 15, calibration_value('a1b2c3d4e5f')
    assert_equal 77, calibration_value('treb7uchet')
  end

  def test_right_calibration_value
    # assert_equal 29, right_calibration_value('two1nine')
    assert_equal 83, right_calibration_value('eightwothree')
    assert_equal 13, right_calibration_value('abcone2threexyz')
    assert_equal 24, right_calibration_value('xtwone3four')
    assert_equal 42, right_calibration_value('4nineeightseven2')
    assert_equal 14, right_calibration_value('zoneight234')
    assert_equal 76, right_calibration_value('7pqrstsixteen')
  end

  def test_sum_calibration_doc
    calibration_doc = <<-DOC
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    DOC
    assert_equal 142, sum_calibration_doc(calibration_doc)

    calibration_doc = <<-DOC
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    DOC

    assert_equal 281, sum_calibration_doc(calibration_doc, :right_calibration_value)
  end
end