class Card
  attr_reader :numbers, :winning_numbers, :card_id
  def initialize(card_string)
    parse_card_string(card_string)
  end

  def matches
    @matches ||= self.numbers & self.winning_numbers
  end

  def points
    self.matches.empty? ? 0 : 2 ** (self.matches.size - 1)
  end

  private
  def parse_card_string(card_string)
    @card_id, all_numbers = card_string.split(":")
    @winning_numbers, @numbers = all_numbers.split("|").map { |n| n.split(" ").map(&:to_i) }
  end
end

class CardsStack
  attr_reader :original_stack


  def initialize(stack_doc)
    @copies = Hash.new(1)
    @processed = false
    @original_stack = parse(stack_doc)
  end

  def points
    self.original_stack.inject(0) { |sum, card| sum += card.points; sum }
  end

  private
  def parse(stack_doc)
    stack_doc.split("\n").map { |card_string| Card.new(card_string) }
  end
end


if __FILE__ == $PROGRAM_NAME
  stack = File.read("input.txt")
  puts Card.pile_points(stack)
end