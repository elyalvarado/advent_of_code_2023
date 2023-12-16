
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
  def initialize(doc)
    @registers = Registers.new
    @hashes = {}
    process(doc)
  end

  def registers
    @registers.registers
  end

  def focusing_power
    @registers.focusing_power
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
    lens = Lens.new(label, focal_length.to_i)
    register = hashes(label)
    @registers.equal(register: register, lens: lens)
  end

  def minus(instruction)
    label, focal_length = instruction.split('-')
    lens = Lens.new(label, focal_length)
    register = hashes(label)
    @registers.minus(register: register, lens: lens)
  end

  def hashes(label)
    return @hashes[label] if @hashes[label]
    @hashes[label] = Hasher.new(label).hash
  end
end

class Registers
  attr_reader :registers
  def initialize
    @registers = Hash.new { |hash, key| hash[key] = [] }
  end

  def minus(register:, lens:)
    registers[register] = registers[register].reject { |registered_lens| registered_lens.label == lens.label }
  end

  def equal(register:, lens:)
    registered_lens = registers[register].find { |registered_lens| registered_lens.label == lens.label }
    registered_lens ? registered_lens.focal_length = lens.focal_length : registers[register] << lens
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
end


if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt').strip
  puts SequenceHasher.new(doc).hash
  puts Processor.new(doc).focusing_power
end