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

def gear_ratios(schematic)

end

def adjacent_positions(char, line, matrix)
  matrix_height = matrix.size
  matrix_width = matrix.first.size
  coords = []
  coords << [line - 1, char - 1] unless char - 1 < 0 || line - 1 < 0
  coords << [line - 1, char] unless line - 1 < 0
  coords << [line - 1, char + 1] unless char + 1 > matrix_width - 1 || line - 1 < 0
  coords << [line, char - 1] unless char - 1 < 0
  coords << [line, char + 1] unless char + 1 > matrix_width - 1
  coords << [line + 1, char - 1] unless char - 1 < 0 || line + 1 > matrix_height - 1
  coords << [line + 1, char] unless line + 1 > matrix_height - 1
  coords << [line + 1, char + 1] unless char + 1 > matrix_width - 1 || line + 1 > matrix_height - 1
  coords
end

def has_adjacent_symbol?(char, line, matrix)
  adjacent_positions(char, line, matrix)
    .reject { |coord| matrix[coord[0]][coord[1]] == "."}
    .reject { |coord| matrix[coord[0]][coord[1]] =~ /\d/ }
    .size > 0
end

def adjacent_gears(char, line, matrix)

end

def schematic_to_matrix(schematic)
  schematic.split("\n").map { |line| line.split("") }
end

def schematic_sum(schematic)
  adjacent_numbers(schematic).inject(&:+)
end

def gears_sum(schematic)
  gear_ratios(schematic).inject(&:+)
end

if __FILE__ == $PROGRAM_NAME
  schematic = File.read("input.txt")
  puts adjacent_numbers(schematic).inject(&:+)
end