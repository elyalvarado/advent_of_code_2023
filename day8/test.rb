require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day8 < Minitest::Test
  MAP = <<~DOC
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
  DOC

  def test_parse_map_nodes
    expected_nodes_hash = {
      'AAA' => ['BBB', 'CCC'],
      'BBB' => ['DDD', 'EEE'],
      'CCC' => ['ZZZ', 'GGG'],
      'DDD' => ['DDD', 'DDD'],
      'EEE' => ['EEE', 'EEE'],
      'GGG' => ['GGG', 'GGG'],
      'ZZZ' => ['ZZZ', 'ZZZ']
    }
    assert_equal expected_nodes_hash, NetworkMap.new(MAP).nodes
  end

  def test_initial_moves
    assert_equal 0, NetworkMap.new(MAP).moves
  end

  def test_parse_map_instructions
    assert_equal 'R', NetworkMap.new(MAP).current_instruction.value
    assert_equal 1, NetworkMap.new(MAP).current_instruction.index_value
  end

  def test_instructions_navigation
    network_map = NetworkMap.new(MAP)
    assert_equal 'R', network_map.current_instruction.value
    network_map.move!
    assert_equal 'L', network_map.current_instruction.value
    network_map.move!
    assert_equal 'R', network_map.current_instruction.value
    assert_equal false, network_map.move!
  end

  def test_complete
    network_map = NetworkMap.new(MAP)
    network_map.complete!
    assert_equal 2, network_map.moves
  end

  def test_complete_longer_map
    longer_map = <<~DOC
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    DOC

    network_map = NetworkMap.new(longer_map)
    network_map.complete!
    assert_equal 6, network_map.moves
  end

end