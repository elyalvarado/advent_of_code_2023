def calibration_value(word)
  numbers = word.chars.select do |char|
    char.to_i.to_s == char
  end
  (numbers.first +  numbers.last).to_i
end

def sum_calibration_doc(doc)
  line_values = doc.split("\n").map do |line|
    calibration_value(line)
  end
  line_values.inject(&:+)
end