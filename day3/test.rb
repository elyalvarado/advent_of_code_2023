require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day3 < Minitest::Test
  SCHEMATIC = <<~DOC
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
  DOC

  def test_schematic_to_matrix
    test_schematic = <<~DOC
      123
      456
      789
    DOC
    assert_equal schematic_to_matrix(test_schematic),
                 [
                   %w{1 2 3},
                   %w{4 5 6},
                   %w{7 8 9}
                 ]
  end

  def test_adjacent_positions
    matrix = schematic_to_matrix(SCHEMATIC)
    assert_equal adjacent_positions(0, 0, matrix).sort,
                 %w{6 . .}.sort

    assert_equal adjacent_positions(2, 0, matrix).sort,
                 %w{6 . . . *}.sort

    assert_equal adjacent_positions(3, 2, matrix).sort,
                 %w{. * . 3 . . . .}.sort
  end

  def test_has_adjacent_symbol?
    matrix = schematic_to_matrix(SCHEMATIC)
    assert_equal false, has_adjacent_symbol?(0, 0, matrix)
    assert_equal true, has_adjacent_symbol?(2, 0, matrix)
    assert_equal true, has_adjacent_symbol?(3, 2, matrix)
    assert_equal false, has_adjacent_symbol?(7, 5, matrix)
  end

  def test_adjacent_numbers
    assert_equal adjacent_numbers(SCHEMATIC).sort,
                 [ 467, 35, 633, 617, 592, 755, 664, 598 ].sort
  end
end