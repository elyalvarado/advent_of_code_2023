require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day4 < Minitest::Test
  CARDS = <<~DOC
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  DOC

  def card(number)
    Card.new(CARDS.split("\n")[number-1])
  end

  def test_card_winning_numbers
    assert_equal [41,48,83,86,17], card(1).winning_numbers
  end

  def test_card_numbers
    assert_equal [83,86,6,31,17,9,48,53], card(1).numbers
  end

  def test_card_matches
    assert_equal [48, 83, 17, 86].sort, card(1).matches.sort
  end

  def test_card_points
    assert_equal 8, card(1).points
    assert_equal 2, card(2).points
    assert_equal 2, card(3).points
    assert_equal 1, card(4).points
    assert_equal 0, card(5).points
    assert_equal 0, card(6).points
  end

  def test_pile_points
    assert_equal 13, Card.pile_points(CARDS)
  end
end