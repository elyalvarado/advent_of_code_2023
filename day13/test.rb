require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test
  MIRRORDOC1 = <<~DOC
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.
  DOC

  MIRRORDOC2 = <<~DOC
    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
  DOC

  def test_vertical_lor
    assert_equal 5, Mirror.new(MIRRORDOC1).vertical_lor
  end

  def test_vertical_lor_zero
    assert_equal 0, Mirror.new(MIRRORDOC2).vertical_lor
  end
  def test_horizontal_lor
    assert_equal 4, Mirror.new(MIRRORDOC2).horizontal_lor
  end

  def test_horizontal_lor_zero
    assert_equal 0, Mirror.new(MIRRORDOC1).horizontal_lor
  end

end