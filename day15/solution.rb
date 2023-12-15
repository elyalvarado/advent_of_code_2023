
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

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
end