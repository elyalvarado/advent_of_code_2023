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

  MIRRORDOC3 = <<~DOC
    .##...#.#
    ####....#
    ...####.#
    #..#.####
    .##.##.##
    #####.#.#
    ....#####
    .##.##.#.
    .##..##.#
    #..#.####
    .##...##.
    #..#..###
    #..#..###
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

  def test_horizontal_lor_2
    assert_equal 12, Mirror.new(MIRRORDOC3).horizontal_lor
  end

  def test_horizontal_lor_zero
    assert_equal 0, Mirror.new(MIRRORDOC1).horizontal_lor
  end

  def test_horizontal_lor_with_smudge
    assert_equal 3, Mirror.new(MIRRORDOC1).horizontal_lor(smudges: 1)
  end

  def test_horizontal_lor_with_smudge2
    assert_equal 1, Mirror.new(MIRRORDOC2).horizontal_lor(smudges: 1)
  end

  def test_vertical_lor_with_smudge
    assert_equal 0, Mirror.new(MIRRORDOC1).vertical_lor(smudges: 1)
    assert_equal 0, Mirror.new(MIRRORDOC2).vertical_lor(smudges: 1)
  end

  def test_summarize
    doc = MIRRORDOC1 + "\n" + MIRRORDOC2
    assert_equal 405, MirrorCollection.new(doc).summarize
  end

end