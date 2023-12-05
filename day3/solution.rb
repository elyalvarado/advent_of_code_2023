def adjacent_numbers(schematic)
  matrix = schematic_to_matrix(schematic)
  matrix_width = matrix.first.size
  numbers = []
  matrix.each_with_index do |line, line_index|
    number = ""
    is_adjacent = false
    line.each_with_index do |char, char_index|
      is_a_number = char =~ /\d/
      if is_a_number
        number << char
        is_adjacent = is_adjacent || has_adjacent_symbol?(char_index, line_index, matrix)
        if char_index == matrix_width - 1
          numbers << number.to_i if is_adjacent
          number = ""
          is_adjacent = false
        end
      else
        numbers << number.to_i if is_adjacent && number != ""
        number = ""
        is_adjacent = false
      end
    end
  end
  numbers
end

def adjacent_positions(char, line, matrix)
  matrix_height = matrix.size
  matrix_width = matrix.first.size
  coords = []
  coords << [char - 1, line - 1] unless char - 1 < 0 || line - 1 < 0
  coords << [char, line - 1] unless line - 1 < 0
  coords << [char + 1, line - 1] unless char + 1 > matrix_width - 1 || line - 1 < 0
  coords << [char - 1, line] unless char - 1 < 0
  coords << [char + 1, line] unless char + 1 > matrix_width - 1
  coords << [char - 1, line + 1] unless char - 1 < 0 || line + 1 > matrix_height - 1
  coords << [char, line + 1] unless line + 1 > matrix_height - 1
  coords << [char + 1, line + 1] unless char + 1 > matrix_width - 1 || line + 1 > matrix_height - 1
  coords.map do |coord|
    char = coord[0]
    line = coord[1]
    matrix[line][char]
  end
end

def has_adjacent_symbol?(char, line, matrix)
  adjacent_positions(char, line, matrix)
    .reject { |char| char == "."}
    .reject { |char| char =~ /\d/ }
    .size > 0
end

def schematic_to_matrix(schematic)
  schematic.split("\n").map { |line| line.split("") }
end

def schematic_sum(schematic)
  adjacent_numbers(schematic).inject(&:+)
end

if __FILE__ == $PROGRAM_NAME
  schematic = File.read("input.txt")
  puts adjacent_numbers(schematic).inject(&:+)
end