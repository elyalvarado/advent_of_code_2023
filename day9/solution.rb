class History
  attr_accessor :matrix

  def initialize(doc)
    @numbers = doc.split(' ').map(&:to_i)
    @matrix = Array.new(@numbers.length).map { Array.new(@numbers.length + 1) }
    @numbers.each_with_index do |number, i|
      @matrix[0][i] = number
    end
  end

  def next2
    current_line_index = 1
    # puts 'filling down'
    while true do
      current_line = @matrix[current_line_index]
      previous_line = @matrix[current_line_index - 1]
      max_index = current_line.length - current_line_index - 2
      (0..max_index).each do |i|
        current_line[i] = previous_line[i+1]-previous_line[i]
      end

      current_line_values = current_line[0..max_index]
      all_zeroes = current_line_values.uniq == [0]
      # debug(@matrix)
      break if all_zeroes
      current_line_index += 1
    end

    # puts 'adding another zero'
    current_line = @matrix[current_line_index]
    add_index = current_line.length - current_line_index - 1
    current_line[add_index] = 0
    current_line_index -= 1
    # debug(@matrix)

    # puts 'filling up'
    while true do
      current_line = @matrix[current_line_index]
      next_line = @matrix[current_line_index + 1]
      max_index = current_line.length - current_line_index - 1
      current_line[max_index] = current_line[max_index-1] + next_line[max_index-1]
      # debug(@matrix)
      return current_line[max_index] if current_line_index == 0
      current_line_index -= 1
    end
  end

  def next
    # debug(@matrix)
    current_line = 1
    current_index = @numbers.length - 2
    while true do
      current_value = calculate_down(current_line, current_index)
      current_line += 1
      current_index -= 1
      # puts "calculated down value #{current_value}"
      # debug(@matrix)
      break if current_value == 0
    end
    n = calculate_up(0, @numbers.length)
    # debug(@matrix)
    # n
  end

  def self.sum_extrapolated(doc)
    next_values = doc.split("\n").map do |line|
      # puts line.split(' ').join(",")
      n = History.new(line).next2
      # puts n
      n
    end
    next_values.reduce(:+)
  end

  private
  def calculate_down(line, index)
    # puts "calcualte down Line #{line} index #{index}"
    return @matrix[line][index] unless @matrix[line][index].nil?
    @matrix[line][index] = calculate_down(line-1,index+1) - calculate_down(line-1,index)
    # if @matrix[line][index] == 0 && @matrix[line][index+1].nil?
    #   # puts "Filling with zeros line #{line}, upto index #{index} because "
    #   (0...index).each do |i|
    #     @matrix[line][i] = 0
    #   end
    # end
    @matrix[line][index]
  end

  def calculate_up(line, index)
    # puts "calculate up Line #{line} index #{index}"
    return @matrix[line][index] unless @matrix[line][index].nil?
    if @matrix[line+1][index-2] == 0
      @matrix[line+1][index-1] = 0
      @matrix[line][index] = @matrix[line][index-1]
      # debug(@matrix)
      return @matrix[line][index]
    end
    @matrix[line][index] = @matrix[line][index-1] + calculate_up(line+1,index-1)
    # debug(@matrix)
    # @matrix[line][index]
  end

  def debug(matrix)
    matrix.each do |l|
      line = l.dup
      break if line.compact.length == 0
      while line.pop.nil?
        true
      end
      line.map! { |v| v.nil? ? 'X' : v }
      puts line.join('|')
    end
    puts '--'
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  puts History.sum_extrapolated(doc)
end