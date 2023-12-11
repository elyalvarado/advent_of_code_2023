class GalaxiesMap
  attr_reader :galaxies

  def initialize(doc)
    @galaxies = []
    @total_lines = 0
    doc.split("\n").each_with_index do |line,line_index|
      line.split("").each_with_index do |char,char_index|
        @galaxies << [line_index, char_index] if char == '#'
      end
      @line_length ||= line.length
      @total_lines += 1
    end
  end

  def rows_without_galaxies
    @rows_without_galaxies ||= (0..(@total_lines-1)).to_a - @galaxies.map { |position| position[0] }
  end

  def columns_without_galaxies
    @columns_without_galaxies ||= (0..(@line_length-1)).to_a - @galaxies.map { |position| position[1] }
  end

  def sum_distances(expansion: 2)
    distance = permutations.inject(0) do |sum, galaxy_pair|
      sum += distance_between_galaxies(*galaxy_pair, expansion: expansion)
      sum
    end
    distance
  end

  def distance_between_galaxies(galaxy1, galaxy2, expansion: 2)
    galaxy_pair = [galaxy1, galaxy2]
    horizontal_coordinates = galaxy_pair.map(&:last).sort
    vertical_coordinates = galaxy_pair.map(&:first).sort
    distance_between(*horizontal_coordinates) +
      columns_without_galaxies_between(*horizontal_coordinates) * (expansion - 1) +
      distance_between(*vertical_coordinates) +
      rows_without_galaxies_between(*vertical_coordinates) * (expansion - 1)
  end

  private
  def permutations
    @permutations ||= @galaxies.permutation(2).map(&:sort).uniq
  end

  def rows_without_galaxies_between(row1,row2)
    (row1..row2).inject(0) { |count, row| count += 1 if rows_without_galaxies.include?(row); count }
  end

  def columns_without_galaxies_between(col1, col2)
    (col1..col2).inject(0) { |count, col| count += 1 if columns_without_galaxies.include?(col); count }
  end

  def distance_between(a,b)
    b-a
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  galaxies_map = GalaxiesMap.new(doc)
  puts galaxies_map.sum_distances
  puts galaxies_map.sum_distances(expansion: 1_000_000)
end