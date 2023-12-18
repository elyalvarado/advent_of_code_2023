require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day < Minitest::Test

  DOC = <<~DOC
    .|...\\....
    |.-.\\.....
    .....|-...
    ........|.
    ..........
    .........\\
    ..../.\\\\..
    .-.-/..|..
    .|....-|.\\
    ..//.|....
  DOC

  def test_energized
    assert_equal 46, Contraption.new(DOC).energized
  end

  def test_max_energized
    assert_equal 51, Contraption.new(DOC).max_energized
  end
end