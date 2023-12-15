require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test

  def test_hash_1
    assert_equal 52, Hasher.new('HASH').hash
  end

  def test_sequence_hasher
    assert_equal 1320, SequenceHasher.new('rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7').hash
  end
end