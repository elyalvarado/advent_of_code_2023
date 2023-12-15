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
    expected_cubes = [[0,0],[1,1],[2,2]]
    assert_equal expected_cubes, Parabolic.new(test_doc).cubes
  end

  def test_rounds
    test_doc = "O..\n.O.\nOOO"
    expected_rounds = [[0,0],[1,1],[2,0],[2,1],[2,2]]
    assert_equal expected_rounds, Parabolic.new(test_doc).rounds
  end

  def test_rows
    test_doc = "#..\n.O.\n..#"
    expected_rows = {
      0 => {
        cubes: [[ 0,0 ]],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [[ 1,1 ]],
      },
      2 => {
        cubes: [[ 2,2 ]],
        rounds: []
      }
    }
    assert_equal expected_rows, Parabolic.new(test_doc).rows
  end

  def test_lines
    test_doc = "#..\n.O.\nO.#"
    expected_lines = {
      0 => {
        cubes: [[ 0,0 ]],
        rounds: []
      },
      1 => {
        cubes: [],
        rounds: [[ 1,1 ]],
      },
      2 => {
        cubes: [[ 2,2 ]],
        rounds: [[ 2,0 ]]
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
    expected_rock = [ 0,1 ]
    assert_equal expected_rock, rock
    assert_equal [expected_rock], parabolic.lines[0][:rounds]
    assert_equal [expected_rock], parabolic.rows[1][:rounds]
    assert_equal [], parabolic.lines[1][:rounds]
  end

  def test_total_load
    parabolic = Parabolic.new(DOC)
    parabolic.tilt
    assert_equal 136, parabolic.total_load
  end

  def test_one_cycle
    after_one_cycle_doc = <<~DOC
      .....#....
      ....#...O#
      ...OO##...
      .OO#......
      .....OOO#.
      .O#...O#.#
      ....O#....
      ......OOOO
      #...O###..
      #..OO#....
    DOC
    expected_rounds = Parabolic.new(after_one_cycle_doc).rounds.sort
    parabolic = Parabolic.new(DOC)
    parabolic.cycle
    assert_equal expected_rounds, parabolic.rounds.sort
  end

  def test_two_cycles
    after_two_cycle_doc = <<~DOC
      .....#....
      ....#...O#
      .....##...
      ..O#......
      .....OOO#.
      .O#...O#.#
      ....O#...O
      .......OOO
      #..OO###..
      #.OOO#...O
    DOC
    expected_rounds = Parabolic.new(after_two_cycle_doc).rounds.sort
    parabolic = Parabolic.new(DOC)
    parabolic.cycle(2)
    assert_equal expected_rounds, parabolic.rounds.sort
  end

  def test_three_cycles
    after_three_cycle_doc = <<~DOC
      .....#....
      ....#...O#
      .....##...
      ..O#......
      .....OOO#.
      .O#...O#.#
      ....O#...O
      .......OOO
      #...O###.O
      #.OOO#...O
    DOC
    expected_rounds = Parabolic.new(after_three_cycle_doc).rounds.sort
    parabolic = Parabolic.new(DOC)
    parabolic.cycle(3)
    assert_equal expected_rounds, parabolic.rounds.sort
  end

end