class Mirror
  attr_reader :width, :height, :matrix, :doc
  def initialize(doc)
    @doc = doc
    @matrix = doc.split("\n").map { |line| line.split("") }
    @width = @matrix[0].size
    @height = @matrix.size
  end

  def vertical_lor
    # lors = []
    (1..(width-1)).each do |row_index|
      # puts "Evaluating row_index #{row_index}"
      is_lor = true
      max_mirror_width = [row_index, width - row_index].min
      # puts "- max_mirror_width #{max_mirror_width}"
      max_mirror_width.times do |delta|
        # puts "  - delta #{delta}"
        height.times do |line_index|
          left_char = matrix[line_index][row_index - delta - 1]
          right_char = matrix[line_index][row_index + delta]
          match =  left_char == right_char
          # puts "Line #{line_index}: Left #{left_char}, Right #{right_char}, Match #{match.inspect}"
          is_lor = is_lor && match
          break unless is_lor
        end
        break unless is_lor
      end
      # puts "- row_index #{row_index} is_lor: #{is_lor.inspect}"
      return row_index if is_lor
    end
    # lors
    0
  end

  def horizontal_lor
    # lors = []
    (1..(height-1)).each do |line_index|
      # puts "Evaluating line_index #{line_index}"
      is_lor = true
      max_mirror_height = [line_index, height - line_index].min
      # puts "- max_mirror_height #{max_mirror_height}"
      max_mirror_height.times do |delta|
        # puts "  - delta #{delta}"
        width.times do |row_index|
          above_char = matrix[line_index - delta - 1][row_index]
          below_char = matrix[line_index + delta][row_index]
          match = above_char == below_char
          # puts "Row #{row_index}: Above #{above_char}, Below #{below_char}, Match #{match.inspect}"
          is_lor = is_lor && match
          break unless is_lor
        end
      end
      # puts "- line_index #{line_index} is_lor: #{is_lor.inspect}"
      return line_index if is_lor
    end
    # lors
    0
  end
end

class MirrorCollection
  def initialize(doc)
    @mirrors = doc.split("\n\n").map { |mirror_doc| Mirror.new(mirror_doc) }
  end

  def summarize
    @mirrors.inject(0) do |summary, mirror|
      puts "v: #{mirror.vertical_lor} h: #{mirror.horizontal_lor}"
      prev_summary = summary
      summary += mirror.vertical_lor
      summary += mirror.horizontal_lor * 100
      puts mirror.doc if prev_summary == summary
      summary
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
  puts MirrorCollection.new(doc).summarize
end