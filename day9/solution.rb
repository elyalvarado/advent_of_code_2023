class History
  attr_accessor :matrix

  def initialize(doc)
    @numbers = doc.split(' ').map(&:to_i)
    @matrix = Array.new(@numbers.length).map { Array.new(@numbers.length + 1) }
    @numbers.each_with_index do |number, i|
      @matrix[0][i] = number
    end
  end

  def next
    # puts @matrix.inspect
    current_line = 1
    current_index = @numbers.length - 2
    while true do
      current_value = calculate_down(current_line, current_index)
      current_line += 1
      current_index -= 1
      # puts "calculated down value #{current_value}"
      # puts @matrix.inspect
      break if current_value == 0
    end
    n = calculate_up(0, @numbers.length)
    # puts @matrix.inspect
    # n
  end

  def self.sum_extrapolated(doc)
    doc.split("\n").map { |line| History.new(line).next }.reduce(:+)
  end

  private
  def calculate_down(line, index)
    # puts "calcualte down Line #{line} index #{index}"
    return @matrix[line][index] unless @matrix[line][index].nil?
    @matrix[line][index] = calculate_down(line-1,index+1) - calculate_down(line-1,index)
    if @matrix[line][index] == 0
      (0...index).each do |i|
        @matrix[line][i] = 0
      end
    end
    @matrix[line][index]
  end

  def calculate_up(line, index)
    # puts "calculate up Line #{line} index #{index}"
    return @matrix[line][index] unless @matrix[line][index].nil?
    if @matrix[line+1][index-2] == 0
      @matrix[line+1][index-1] = 0
      @matrix[line][index] = @matrix[line][index-1]
      # puts @matrix.inspect
      return @matrix[line][index]
    end
    @matrix[line][index] = @matrix[line][index-1] + calculate_up(line+1,index-1)
    # puts @matrix.inspect
    # @matrix[line][index]
  end
end

if __FILE__ == $PROGRAM_NAME

end