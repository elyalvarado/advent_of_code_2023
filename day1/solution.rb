def calibration_value(word)
  numbers = word.chars.select do |char|
    char.to_i.to_s == char
  end
  (numbers.first +  numbers.last).to_i
end

def right_calibration_value(word)
  mappings = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }
  mappings.each do |number_in_words, number|
    fake_number = number_in_words[0] + number.to_s + number_in_words[-1]
    word.gsub!(number_in_words, fake_number)
  end
  calibration_value(word)
end

def sum_calibration_doc(doc, calibration_function = :calibration_value)
  line_values = doc.split("\n").map do |line|
    self.send(calibration_function, line)
  end
  line_values.inject(&:+)
end

if __FILE__ == $PROGRAM_NAME
  puts sum_calibration_doc(File.read("./input.txt"))
  puts sum_calibration_doc(File.read("./input.txt"), :right_calibration_value)
end