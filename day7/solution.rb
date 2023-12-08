class Hand
  include Comparable

  attr_reader :bid, :hand
  def initialize(hand_string)
    @hand, @bid = hand_string.split(" ")
    @bid = @bid.to_i
  end

  def <=>(another)
    return hex_value <=> another.hex_value if repeat_value == another.repeat_value
    repeat_value <=> another.repeat_value
  end

  def repeat_value
    @repeat_value ||= counts[0] * 10e4 +
      (counts[1] || 0) * 10e3 +
      (counts[2] || 0) * 10e2 +
      (counts[3] || 0) * 10e1 +
      (counts[4] || 0)
    # puts "repeat value for #{@hand}: #{@repeat_value}"
    # @repeat_value
  end

  def hex_value
    @hex_value ||= cards.map do |card|
      case card
      when 'A'
        'F'
      when 'K'
        'E'
      when 'Q'
        'D'
      when 'K'
        'C'
      when 'T'
        'B'
      else
        card
      end
    end.join.to_i(16)
    # puts "hex value for #{@hand}: #{@hex_value}"
    # @hex_value
  end

  private
  def counts
    @counts ||= cards.inject(Hash.new(0)) { |hash, card|
      hash[card] += 1
      hash
    }.values.sort.reverse
  end

  def cards
    @cards ||= @hand.split('')
  end
end

class CamelCards
  def initialize(hands_doc)
    @hands = hands_doc.split("\n").map { |line| Hand.new(line)}
  end

  def total_winnings
    winnings = 0
    @hands.sort.each_with_index do |hand, index|
      # puts "hand: #{hand.hand}, bid: #{hand.bid}, index: #{index}"
      winnings += hand.bid * (index+1)
    end
    winnings
  end
end

if __FILE__ == $PROGRAM_NAME

end