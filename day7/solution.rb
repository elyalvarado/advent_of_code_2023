class Hand
  include Comparable

  def initialize(hand_string)
    @hand = hand_string
  end

  def <=>(another)
    repeat_value <=> another.repeat_value
  end

  def repeat_value
    counts[0] * 10e4 +
      (counts[1] || 0) * 10e3 +
      (counts[2] || 0) * 10e2 +
      (counts[3] || 0) * 10e1 +
      (counts[4] || 0)
  end

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

if __FILE__ == $PROGRAM_NAME

end