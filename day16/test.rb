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
end