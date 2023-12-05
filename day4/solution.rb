class Card
  attr_reader :numbers, :winning_numbers
  def initialize(card_string)
    parse_card_string(card_string)
  end

  def matches
    @matches ||= self.numbers & self.winning_numbers
  end

  def points
    self.matches.empty? ? 0 : 2 ** (self.matches.size - 1)
  end

  def self.pile_points(doc)
    cards = doc.split("\n").map { |card_string| Card.new(card_string) }
    cards.inject(0) { |sum, card| sum += card.points; sum }
  end

  private
  def parse_card_string(card_string)
    @card_id, all_numbers = card_string.split(":")
    @winning_numbers, @numbers = all_numbers.split("|").map { |n| n.split(" ").map(&:to_i) }
  end
end


if __FILE__ == $PROGRAM_NAME
  stack = File.read("input.txt")
  puts Card.pile_points(stack)
end