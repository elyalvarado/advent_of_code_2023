class Contraption
  def initialize(doc)
    @matrix = doc.split("\n").map { |line| line.split('') }
    @height = @matrix.size
    @width = @matrix.first.size
    position = [0,0]
    entering_direction = [0,1]
    directions = DIRECTION_MAPS[@matrix.first.first][entering_direction]
    @stack = directions.map { |direction| [position, direction] }
    @energized_hash = Hash.new { |hash, key| hash[key] = [] }
  end

  def energized
    while true do
      break if @stack.empty?
      position, direction = @stack[0]
      puts "position: #{position.inspect}"
      # puts "direction: #{direction.inspect}"

      if @energized_hash[position].include?(direction)
        puts "Already went down this path"
        @stack.shift
        next
      else
        # puts "Energizing position #{position.inspect}"
        @energized_hash[position].push(direction)
      end

      next_position = [position[0] + direction[0], position[1] + direction[1]]
      if out_of_bounds(next_position)
        puts "Next position out of bounds. Removing from stack."
        # break
        @stack.shift
        next
      end

      next_position_char = @matrix[next_position[0]][next_position[1]]
      # puts "next_position: #{next_position.inspect} (char: #{next_position_char})"
      next_directions = DIRECTION_MAPS[next_position_char][direction]
      # puts "next_directions: #{next_directions.inspect}"

      next_direction = next_directions[0]
      @stack[0][0] = next_position
      @stack[0][1] = next_direction
      # puts "next_direction: #{next_direction}"

      if next_directions.size > 1
        alt = [next_position, next_directions[1]]
        @stack << alt
        puts "Pushing to stack #{alt} (Current stack size: #{@stack.size})"
      end
    end

    @energized_hash.keys.size
  end

  private

  DIRECTION_MAPS = {
    '.' => {
      [0,1] => [[0,1]],
      [0,-1] => [[0,-1]],
      [1,0] => [[1,0]],
      [-1,0] => [[-1,0]],
    },
    '/' => {
      [0,1] => [[-1,0]],
      [0,-1] => [[1,0]],
      [1,0] => [[0,-1]],
      [-1,0] => [[0,1]],
    },
    '\\' => {
      [0,1] => [[1,0]],
      [0,-1] => [[-1,0]],
      [1,0] => [[0,1]],
      [-1,0] => [[0,-1]],
    },
    '|' => {
      [0,1] => [[1,0],[-1,0]],
      [0,-1] => [[1,0],[-1,0]],
      [1,0] => [[1,0]],
      [-1,0] => [[-1,0]],
    },
    '-' => {
      [0,1] => [[0,1]],
      [0,-1] => [[0,-1]],
      [1,0] => [[0,1],[0,-1]],
      [-1,0] => [[0,1],[0,-1]],
    }
  }

  def out_of_bounds(position)
    position[0] < 0 || position[0] >= @height || position[1] < 0 || position[1] >= @width
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  puts Contraption.new(doc).energized
end