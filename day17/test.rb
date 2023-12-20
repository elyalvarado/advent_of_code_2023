require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test
  DOC = <<~DOC
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
  DOC

  DOC2 = <<~DOC
    24134
    32154
  DOC

  def test_minimal_heat_loss
    assert_equal 102, CrucibleMap.new(DOC).minimal_heat_loss
  end

  def xtest_minimal_heat_loss_small
    assert_equal 10, CrucibleMap.new(DOC2).minimal_heat_loss
  end
end