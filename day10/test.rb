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

  def test_count_in_1
    doc = <<~DOC
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........
    DOC
    pipe_map = PipeMap.new(doc)
    pipe_map.complete_round
    assert_equal 4, pipe_map.count_in
  end

  def test_count_in_2
    doc = <<~DOC
      ..........
      .S------7.
      .|F----7|.
      .||OOOO||.
      .||OOOO||.
      .|L-7F-J|.
      .|II||II|.
      .L--JL--J.
      ..........
    DOC
    pipe_map = PipeMap.new(doc)
    pipe_map.complete_round
    assert_equal 4, pipe_map.count_in
  end

  def test_count_in_3
    doc = <<~DOC
      .F----7F7F7F7F-7....
      .|F--7||||||||FJ....
      .||.FJ||||||||L7....
      FJL7L7LJLJ||LJ.L-7..
      L--J.L7...LJS7F-7L7.
      ....F-J..F7FJ|L7L7L7
      ....L7.F7||L7|.L7L7|
      .....|FJLJ|FJ|F7|.LJ
      ....FJL-7.||.||||...
      ....L---J.LJ.LJLJ...
    DOC
    pipe_map = PipeMap.new(doc)
    pipe_map.complete_round
    assert_equal 8, pipe_map.count_in
  end

  def test_count_in_4
    doc = <<~DOC
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
    DOC
    pipe_map = PipeMap.new(doc)
    pipe_map.complete_round
    assert_equal 10, pipe_map.count_in
  end
end