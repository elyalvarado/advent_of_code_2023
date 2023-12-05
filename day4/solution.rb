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
    @processed = false
    @original_stack = parse(stack_doc)
    @copies = @original_stack.inject({}) { |current_copies, card| current_copies[card.card_id] = 1; current_copies }
  end

  def points
    self.original_stack.inject(0) { |sum, card| sum += card.points; sum }
  end

  def total_scratch_cards
    process_all_winners_and_copies
    total = 0
    @copies.each do |card_id, copies|
      total += copies
    end
    total
  end

  private
  def parse(stack_doc)
    stack_doc.split("\n").map { |card_string| Card.new(card_string) }
  end

  def process_all_winners_and_copies
    return if @processed

    self.original_stack.each_with_index do |card, card_index|
      card_id = card.card_id
      # puts "Processing Card #{card.card_id}"
      # puts " - Initial copies: #{@copies.inspect}"
      wins = card.matches.size
      # puts " - wins: #{wins}"
      multiplier = @copies[card_id]
      # puts " - current copies of #{card_id}: #{@copies[card_id]}"
      wins.times do |win_index|
        current_index = card_index + win_index + 1
        current_card = self.original_stack[current_index]
        next unless current_card
        current_card_id = current_card.card_id
        @copies[current_card_id] = @copies[current_card_id] + multiplier
      end
      # puts " - Final copies: #{@copies.inspect}"
    end

    @processed = true
  end
end


if __FILE__ == $PROGRAM_NAME
  stack = File.read("input.txt")
  card_stack = CardsStack.new(stack)
  puts card_stack.points
  puts card_stack.total_scratch_cards
end