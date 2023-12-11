require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day10 < Minitest::Test
  PIPEMAP1 =<<~DOC
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
  DOC

  PIPEMAP2 =<<~DOC
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
  DOC

  def test_find_starting_position_1
    assert_equal [1, 1], PipeMap.new(PIPEMAP1).starting_position
  end

  def test_find_starting_position_2
    assert_equal [2, 0], PipeMap.new(PIPEMAP2).starting_position
  end

  def test_initial_current_position
    assert_equal [1,1], PipeMap.new(PIPEMAP1).current_position
  end

  def test_initial_previous_position
    assert_nil PipeMap.new(PIPEMAP1).previous_position
  end

  def test_initial_moves
    assert_equal 0, PipeMap.new(PIPEMAP1).moves
  end

  def test_first_move
    pipe_map = PipeMap.new(PIPEMAP1)
    pipe_map.move
    assert_equal [1,2], pipe_map.current_position
    assert_equal [1,1], pipe_map.previous_position
    assert_equal 1, pipe_map.moves
  end

  def test_complete_round_1
    pipe_map = PipeMap.new(PIPEMAP1)
    pipe_map.complete_round
    assert_equal pipe_map.starting_position, pipe_map.current_position
    assert_equal 8, pipe_map.moves
  end

  def test_complete_round_2
    pipe_map = PipeMap.new(PIPEMAP2)
    pipe_map.complete_round
    assert_equal pipe_map.starting_position, pipe_map.current_position
    assert_equal 16, pipe_map.moves
  end
end