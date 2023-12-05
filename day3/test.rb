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
                 [[0, 1], [1, 0], [1, 1]]

    assert_equal adjacent_positions(2, 0, matrix).sort,
                 [[0, 1], [0, 3], [1, 1], [1, 2], [1, 3]]

    assert_equal adjacent_positions(3, 2, matrix).sort,
                 [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
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

  def test_schematic_sum
    assert_equal 4361, schematic_sum(SCHEMATIC)
  end

  def test_adjacent_gears
    matrix = schematic_to_matrix(SCHEMATIC)
    assert_equal [ [1, 3] ], adjacent_gears(2,0,matrix)
  end

  def xtest_gear_ratios
    assert_equal gear_ratios(SCHEMATIC).sort,
                 [ 16345, 451490 ].sort
  end

  def xtest_gears_sum
    assert_equal 467835, gears_sum(SCHEMATIC)
  end
end