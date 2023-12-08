require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day7 < Minitest::Test

  def test_hand_order_five_over_four
    assert_equal true, Hand.new('11111 1') > Hand.new('11112 1')
  end

  def test_hand_order_four_over_full_house
    assert_equal true, Hand.new('11112 1') > Hand.new('11122 1')
  end

  def test_hand_order_full_house_over_three
    assert_equal true, Hand.new('11122 1') > Hand.new('11123 1')
  end

  def test_hand_order_three_over_two_pairs
    assert_equal true, Hand.new('11123 1') > Hand.new('11223 1')
  end

  def test_hand_order_two_pairs_over_one_pair
    assert_equal true, Hand.new('11223 1') > Hand.new('11234 1')
  end

  def test_hand_order_two_over_one
    assert_equal true, Hand.new('11234 1') > Hand.new('12345 1')
  end

  def test_high_card_no_repeats
    assert_equal true, Hand.new('54321 1') > Hand.new('12345 1')
  end

  def test_high_card_five
    assert_equal true, Hand.new('22222 1') > Hand.new('11111 1')
  end

  def test_high_card_four
    assert_equal true, Hand.new('21111 1') > Hand.new('1AAAA 1')
  end

  HANDS_LIST = <<~DOC
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
  DOC

  def test_total_winnings
    assert_equal 6440, CamelCards.new(HANDS_LIST).total_winnings
  end


end