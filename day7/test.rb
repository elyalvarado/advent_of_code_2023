require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day7 < Minitest::Test

  def test_hand_order_five_over_four
    assert_equal true, Hand.new('11111') > Hand.new('11112')
  end

  def test_hand_order_four_over_full_house
    assert_equal true, Hand.new('11112') > Hand.new('11122')
  end

  def test_hand_order_full_house_over_three
    assert_equal true, Hand.new('11122') > Hand.new('11123')
  end

  def test_hand_order_three_over_two_pairs
    assert_equal true, Hand.new('11123') > Hand.new('11223')
  end

  def test_hand_order_two_pairs_over_one_pair
    assert_equal true, Hand.new('11223') > Hand.new('11234')
  end

  def test_hand_order_two_over_one
    assert_equal true, Hand.new('11234') > Hand.new('12345')
  end

  def test_high_card_no_repeats
    assert_equal true, Hand.new('54321') > Hand.new('12345')
  end

  def test_high_card_five
    assert_equal true, Hand.new('22222') > Hand.new('11111')
  end

  def test_high_card_four
    assert_equal true, Hand.new('21111') > Hand.new('1AAAA')
  end

end