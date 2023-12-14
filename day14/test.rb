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

  def test_cubes
    test_doc = "#..\n.#.\n..#"
    expected_cubes = [[0,0],[1,1],[2,2]]
    assert_equal expected_cubes, Parabolic.new(test_doc).cubes
  end

  def test_rounds
    test_doc = "0..\n.0.\n000"
    expected_rounds = [[0,0],[1,1],[2,0],[2,1],[2,2]]
    assert_equal expected_rounds, Parabolic.new(test_doc).rounds
  end

  def test_rows
    test_doc = "#..\n.0.\n..#"
    expected_rows = {
      0 => {
        cubes: [[0,0]],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [[1,1]],
      },
      2 => {
        cubes: [[2,2]],
        rounds: []
      }
    }
    assert_equal expected_rows, Parabolic.new(test_doc).rows
  end

  def test_lines
    test_doc = "#..\n.0.\n0.#"
    expected_lines = {
      0 => {
        cubes: [[0,0]],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [[1,1]],
      },
      2 => {
        cubes: [[2,2]],
        rounds: [[2,0]]
      }
    }
    assert_equal expected_lines, Parabolic.new(test_doc).lines
  end

  def test_move_rock
    test_doc = "#..\n.0.\n..#"
    parabolic = Parabolic.new(test_doc)
    rock = parabolic.rounds.first
    delta = [-1,0]
    parabolic.move(rock, delta)
    assert_equal [0,1], rock
    assert_equal [[0,1]], parabolic.lines[0][:rounds]
    assert_equal [[0,1]], parabolic.rows[1][:rounds]
    assert_equal [], parabolic.lines[1][:rounds]
  end

  def test_total_load
    assert_equal 136, Parabolic.new(DOC).total_load
  end
end