
class Parabolic
  attr_reader :matrix, :width, :height
  def initialize(doc)
    @matrix = doc.split("\n").map { |line| line.split("") }
    @width = @matrix.first.size
    @height = @matrix.size
    cubes; rounds; lines; rows # prepulate lines and rows
  end

  def tilt
    tilt_north
  end

  def total_load
    rounds.inject(0) { |sum, round| sum+=(height-round[0]); sum}
  end

  def cycle(times = 1)
    times.times do
      tilt_north
      tilt_west
      tilt_south
      tilt_east
    end
  end

  def move(rock, delta)
    # puts "lines"
    # puts lines.inspect
    # puts "---"
    # puts "rows"
    # puts rows.inspect
    # puts '---'
    current_rock_row = rock[1]
    current_rock_line = rock[0]
    rock[0] += delta[0]
    rock[1] += delta[1]
    if current_rock_row != rock[1]
      rows[current_rock_row][:rounds].delete(rock)
      rows[rock[1]][:rounds] << rock
    end

    if current_rock_line != rock[0]
      lines[current_rock_line][:rounds].delete(rock)
      lines[rock[0]][:rounds] << rock
    end
    # puts "lines"
    # puts lines.inspect
    # puts "---"
    # puts "rows"
    # puts rows.inspect
    # puts '---'
  end

  def cubes
    @cubes ||= find_rocks('#')
  end

  def rounds
    @rounds ||= find_rocks('O')
  end

  def rows
    return @rows if @rows
    @rows = width.times.inject({}) do |hash, i|
      hash[i] = { cubes: [], rounds: [] }
      hash
    end
    cubes.each { |cube| @rows[cube[1]][:cubes] << cube }
    rounds.each { |round| @rows[round[1]][:rounds] << round }
    @rows
  end

  def lines
    return @lines if @lines
    @lines = height.times.inject({}) do |hash, i|
      hash[i] = { cubes: [], rounds: [] }
      hash
    end
    cubes.each { |cube| @lines[cube[0]][:cubes] << cube }
    rounds.each { |round| @lines[round[0]][:rounds] << round }
    @lines
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

  def tilt_north
    rows.each do |row_index, row|
      prev_cube_line = -1
      (row[:cubes].size+1).times.each do |index|
        cube = row[:cubes][index] || [height, row_index]
        cube_line = cube[0]
        rounds_within = row[:rounds]
                          .select { |round| round[0] > prev_cube_line && round[0] < cube_line }
                          .sort_by { |round| round[0] }
        rounds_within.each_with_index do |round, round_index|
          move_by = (prev_cube_line + 1) - round[0] + round_index
          move(round, [move_by, 0])
        end
        prev_cube_line = cube_line
      end
    end
  end

  def tilt_west
    lines.each do |line_index, line|
      prev_cube_row = -1
      (line[:cubes].size+1).times.each do |index|
        cube = line[:cubes][index] || [line_index, width]
        cube_row = cube[1]
        rounds_within = line[:rounds]
                          .select { |round| round[1] > prev_cube_row && round[1] < cube_row }
                          .sort_by { |round| round[0] }
        rounds_within.each_with_index do |round, round_index|
          move_by = (prev_cube_row + 1) - round[1] + round_index
          move(round, [0, move_by])
        end
        prev_cube_row = cube_row
      end
    end
  end

  def tilt_south
    rows.each do |row_index, row|
      prev_cube_line = -1
      (row[:cubes].size+1).times.each do |index|
        cube = row[:cubes][index] || [height, row_index]
        cube_line = cube[0]
        rounds_within = row[:rounds]
                          .select { |round| round[0] > prev_cube_line && round[0] < cube_line }
                          .sort_by { |round| round[0] }
                          .reverse
        rounds_within.each_with_index do |round, round_index|
          move_by = cube_line - 1 - round[0] - round_index
          move(round, [move_by, 0])
        end
        prev_cube_line = cube_line
      end
    end
  end

  def tilt_east
    lines.each do |line_index, line|
      prev_cube_row = -1
      (line[:cubes].size+1).times.each do |index|
        cube = line[:cubes][index] || [line_index, width]
        cube_row = cube[1]
        rounds_within = line[:rounds]
                          .select { |round| round[1] > prev_cube_row && round[1] < cube_row }
                          .sort_by { |round| round[0] }
                          .reverse
        rounds_within.each_with_index do |round, round_index|
          move_by = cube_row - 1 - round[1] - round_index
          move(round, [0, move_by])
        end
        prev_cube_row = cube_row
      end
    end
  end
end

class Rock
  def initialize(y, x)
    @y = y
    @x = x
  end

  def [](idx)
    case idx
    when 0
      @y
    when 1
      @x
    else
      nil
    end
  end

  def []=(idx, value)
    case idx
    when 0
      @y = value
    when 1
      @x = value
    else
      # do nothing
    end
  end

  def ==(another)
    self[0] == another[0] && self[1] == another[1]
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  puts Parabolic.new(doc).total_load
end