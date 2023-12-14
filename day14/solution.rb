
class Parabolic
  attr_reader :matrix, :width, :height
  def initialize(doc)
    @matrix = doc.split("\n").map { |line| line.split("") }
    @width = @matrix.first.size
    @height = @matrix.size
  end

  def total_load
    total_load = 0
    width.times do |row|
      last_round_rock = -1
      last_cube_rock = -1
      height.times do |line|
        # puts "line #{line} row #{row}: char #{matrix[line][row]} (last_cube: #{last_cube_rock}, last_round: #{last_round_rock}"
        case matrix[line][row]
        when '#'
          # puts "- Updating last_cube_rock to #{line}"
          last_cube_rock = line
        when 'O'
          if last_cube_rock > last_round_rock
            move_to_line = last_cube_rock + 1
            last_round_rock = move_to_line
            total_load += height - move_to_line
            # puts "- Moving round rock and setting last_round to #{move_to_line}"
            # puts "- Incrementing score to: #{total_load} (increment #{height - move_to_line})"
          else
            move_to_line = last_round_rock + 1
            last_round_rock = move_to_line
            total_load += height - move_to_line
            # puts "- Moving round rock and setting last_round to #{move_to_line}"
            # puts "- Incrementing score to: #{total_load} (increment #{height - move_to_line})"
          end
        else
          # puts '- Nothing to do here'
        end
      end
    end
    total_load
  end

  def cubes
    @cubes ||= find_rocks('#')
  end

  def rounds
    @rounds ||= find_rocks('0')
  end

  private
  def find_rocks(shape)
    matrix.each.with_index.inject([]) do |line_cubes, line_and_index|
      line, line_index = *line_and_index
      line.each_with_index do |char, char_index|
        line_cubes << [line_index, char_index] if char == shape
      end
      line_cubes
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  puts Parabolic.new(doc).total_load
end