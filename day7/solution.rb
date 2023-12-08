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
      when 'J'
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

class HandJokerRule < Hand
  def repeat_value
    @repeat_value ||= ((counts[0] || 0) + count_jokers) * 10e4 +
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
      when 'J'
        '0'
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
      hash[card] += 1 unless card == 'J'
      hash
    }.values.sort.reverse
  end

  def count_jokers
    @count_jokers = cards.select { |c| c == 'J' }.size
  end
end

class CamelCards
  def initialize(hands_doc, rules: Hand)
    @hands = hands_doc.split("\n").map { |line| rules.new(line)}
  end

  def total_winnings
    winnings = 0
    @hands.sort.each_with_index do |hand, index|
      # puts "hand: #{hand.hand}, bid: #{hand.bid}, index: #{index}, repeat_value: #{hand.repeat_value}, hex_value: #{hand.hex_value}"
      winnings += hand.bid * (index+1)
    end
    winnings
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read("input.txt")
  camel_cards = CamelCards.new(doc)
  puts camel_cards.total_winnings
  joker_rules = CamelCards.new(doc, rules: HandJokerRule)
  puts joker_rules.total_winnings
end