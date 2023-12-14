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
    test_doc = "O..\n.O.\n..O"
    assert_equal [ %w{O . .}, %w{. O .}, %w{. . O}], Parabolic.new(test_doc).matrix
  end

  def test_cubes
    test_doc = "#..\n.#.\n..#"
    expected_cubes = [[0,0],[1,1],[2,2]].map { |c| Rock.new(*c) }
    assert_equal expected_cubes, Parabolic.new(test_doc).cubes
  end

  def test_rounds
    test_doc = "O..\n.O.\nOOO"
    expected_rounds = [[0,0],[1,1],[2,0],[2,1],[2,2]].map { |c| Rock.new(*c) }
    assert_equal expected_rounds, Parabolic.new(test_doc).rounds
  end

  def test_rows
    test_doc = "#..\n.O.\n..#"
    expected_rows = {
      0 => {
        cubes: [Rock.new(0,0)],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [Rock.new(1,1)],
      },
      2 => {
        cubes: [Rock.new(2,2)],
        rounds: []
      }
    }
    assert_equal expected_rows, Parabolic.new(test_doc).rows
  end

  def test_lines
    test_doc = "#..\n.O.\nO.#"
    expected_lines = {
      0 => {
        cubes: [Rock.new(0,0)],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [Rock.new(1,1)],
      },
      2 => {
        cubes: [Rock.new(2,2)],
        rounds: [Rock.new(2,0)]
      }
    }
    assert_equal expected_lines, Parabolic.new(test_doc).lines
  end

  def test_move_rock
    test_doc = "#..\n.O.\n..#"
    parabolic = Parabolic.new(test_doc)
    rock = parabolic.rounds.first
    delta = [-1,0]
    parabolic.move(rock, delta)
    expected_rock = Rock.new(0,1)
    assert_equal expected_rock, rock
    assert_equal [expected_rock], parabolic.lines[0][:rounds]
    assert_equal [expected_rock], parabolic.rows[1][:rounds]
    assert_equal [], parabolic.lines[1][:rounds]
  end

  def test_total_load
    assert_equal 136, Parabolic.new(DOC).total_load
  end

  def xtest_total_load2
    puts DOC
    assert_equal 136, Parabolic.new(DOC).total_load2
  end

end