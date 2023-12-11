class PipeMap
  attr_reader :starting_position, :current_position, :previous_position, :moves

  DELTAS = {
    "|" => [[1,0],[-1,0]],
    "-" => [[0,1],[0,-1]],
    "L" => [[-1,0],[0,1]],
    "J" => [[-1,0],[0,-1]],
    "7" => [[1,0],[0,-1]],
    "F" => [[0,1],[1,0]]
  }

  def initialize(doc)
    line_index = 0
    @pipemap = doc.split("\n").map do |line|
      line.split("").tap do |line_values|
        break if @starting_position
        s_index = line_values.find_index('S')
        @starting_position = [line_index, s_index] if s_index
      end
      line_index += 1
      line
    end
    @current_position = @starting_position
    @moves = 0
    @previous_position = nil
  end

  def move
    return false if current_char == 'S' && previous_position
    tmp_current = current_position
    @current_position = next_position
    @previous_position = tmp_current
    @moves += 1
    true
  end

  def complete_round
    while move do
      true
    end
    true
  end

  private
  def current_char
    char_for_position(current_position)
  end

  def next_position
    if previous_position
      # puts "pp #{previous_position}"
      deltas = DELTAS[current_char]
      # puts "cc #{current_char}"
      # puts "deltas #{deltas.inspect}"
      positions = deltas.map do |d|
        [current_position[0] + d[0], current_position[1] + d[1]]
      end
      # puts "positions: #{positions.inspect}"
      n = (positions - [previous_position]).first
      # puts "np: #{n.inspect}"
      # n
    else
      up = [current_position[0] - 1, current_position[1]]
      right = [current_position[0], current_position[1] + 1]
      down = [current_position[0] + 1, current_position[1]]
      left = [current_position[0], current_position[1] - 1]
      # check up
      # all = {
      #   up: [ up, char_for_position(up)],
      #   right: [ right, char_for_position(right)],
      #   down: [ down, char_for_position(down)],
      #   left: [ left, char_for_position(left)]
      # }
      # puts @pipemap.inspect
      # puts all.inspect
      return up if %w{| 7 F}.include?(char_for_position(up))
      return right if %w{- 7 J}.include?(char_for_position(right))
      return down if %w{| J L}.include?(char_for_position(down))
      return left if %w{- L F}.include?(char_for_position(left))
      raise
    end
  end

  def char_for_position(position)
    @pipemap[position[0]][position[1]]
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  pipe_map = PipeMap.new(doc)
  pipe_map.complete_round
  puts "Path length: #{pipe_map.moves}, farther point: #{pipe_map.moves/2}"
end