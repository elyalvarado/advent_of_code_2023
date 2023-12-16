require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test

  def test_hash_1
    assert_equal 52, Hasher.new('HASH').hash
  end

  def test_sequence_hasher
    assert_equal 1320, SequenceHasher.new('rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7').hash
  end

  def test_registers_equal
    lens = Lens.new('rn',1)
    registers = Registers.new
    registers.equal(register: 0, lens: lens)
    expected_registers = {
      0 => [lens]
    }
    assert_equal expected_registers, registers.registers
  end

  def test_registers_minus
    lens1 = Lens.new('rn',1)
    lens2 = Lens.new('rn',9)
    registers = Registers.new
    registers.equal(register: 0, lens: lens1)
    registers.minus(register: 0, lens: lens2)
    expected_registers = {
      0 => []
    }
    assert_equal expected_registers, registers.registers
  end

  def test_processor_1
    lens = Lens.new('rn',1)
    expected_registers = {
      0 => [lens]
    }
    assert_equal expected_registers, Processor.new('rn=1').registers
  end

  def test_processor_2
    lens1 = Lens.new('rn',1)
    expected_registers = {
      0 => [lens1]
    }
    assert_equal expected_registers, Processor.new('rn=1,cm-').registers
  end

  def test_processor_3
    lens1 = Lens.new('rn',1)
    lens2 = Lens.new('qp',3)
    expected_registers = {
      0 => [lens1],
      1 => [lens2]
    }
    assert_equal expected_registers, Processor.new('rn=1,cm-,qp=3').registers
  end

  def test_processor_7
    lens1 = Lens.new('rn',1)
    lens2 = Lens.new('cm',2)
    lens3 = Lens.new('ot',7)
    lens4 = Lens.new('ab',5)
    lens5 = Lens.new('pc',6)
    expected_registers = {
      0 => [lens1, lens2],
      1 => [],
      3 => [lens3, lens4, lens5]
    }
    assert_equal expected_registers, Processor.new('rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7').registers
  end

  def test_focusing_power
    assert_equal 145, Processor.new('rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7').focusing_power
  end
end