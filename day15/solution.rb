
class SequenceHasher
  def initialize(sequence)
    @sequence = sequence
    @instructions = @sequence.split(',')
  end

  def hash
    @instructions.inject(0) { |sum, instruction| sum += Hasher.new(instruction).hash; sum }
  end
end

class Hasher
  def initialize(string)
    @string = string
  end

  def hash
    current_value = 0
    @string.split('').each do |char|
      current_value += char.ord
      current_value *= 17
      current_value = current_value % 256
    end
    current_value
  end
end

class Lens
  include Comparable

  attr_accessor :label, :focal_length
  def initialize(label, focal_length)
    @label = label
    @focal_length = focal_length
  end

  def ==(another)
    self.label == another.label && self.focal_length == another.focal_length
  end
end

class Processor
  attr_reader :registers
  def initialize(doc)
    @registers = Hash.new { |hash, key| hash[key] = [] }
    @hashes = {}
    process(doc)
  end

  def focusing_power
    power = 0
    @registers.each do |box, slots|
      slots.each_with_index do |lens, index|
        power += (box + 1)*(index + 1)*(lens.focal_length)
      end
    end
    power
  end

  private
  def process(doc)
    @instructions = doc.split(',')
    @instructions.each { |instruction| process_instruction(instruction) }
  end

  def process_instruction(instruction)
    case instruction
    when /=/
      equal(instruction)
    when /-/
      minus(instruction)
    end
  end

  def equal(instruction)
    label, focal_length = instruction.split('=')
    register = hashes(label)
    registered_lens = @registers[register].find { |registered_lens| registered_lens.label == label }
    registered_lens ? registered_lens.focal_length = focal_length.to_i : @registers[register] << Lens.new(label, focal_length.to_i)
  end

  def minus(instruction)
    label, _ = instruction.split('-')
    register = hashes(label)
    @registers[register] = @registers[register].reject { |registered_lens| registered_lens.label == label }
  end

  def hashes(label)
    return @hashes[label] if @hashes[label]
    @hashes[label] = Hasher.new(label).hash
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt').strip
  puts SequenceHasher.new(doc).hash
  puts Processor.new(doc).focusing_power
end