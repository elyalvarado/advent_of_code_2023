require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test
  DOC = <<~DOC
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
  DOC

  def test_read_matrix
    test_doc = "0..\n.0.\n..0"
    assert_equal [ %w{0 . .}, %w{. 0 .}, %w{. . 0}], Parabolic.new(test_doc).matrix
  end

  def test_total_load
    assert_equal 136, Parabolic.new(DOC).total_load
  end
end