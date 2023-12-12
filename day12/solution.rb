class SpringsMap
  attr_reader :springs
  def initialize(doc)
    @springs = doc.split("\n").map { |line| Spring.new(line)}
  end

  def arrangements
    @springs.inject(0) { |sum, spring| sum += spring.arrangements; sum }
  end
end

class Spring
  def initialize(doc)
    @og_string, groups = doc.split(' ')
    @groups = groups.split(',').map(&:to_i)
  end

  def arrangements
    alternatives.inject(0) do |count, alternative|
      # puts "Evaluating alternative #{alternative} for #{@groups.inspect}"
      alternative_groups = (alternative.split('.')-['']).map(&:size)
      # puts "Alternative groups: #{alternative_groups}"
      # puts "Valid alternative" if alternative_groups == @groups
      count += 1 if alternative_groups == @groups
      # puts '---'
      count
    end
  end

  private
  def alternatives
    @alternatives ||= alternatives_for(@og_string)
    # puts @alternatives.inspect
    # puts "Total #{@alternatives.size} #{@alternatives.uniq.size} uniq"
    @alternatives
  end

  def alternatives_for(string)
    return [ string ] unless string.include?('?')
    first_question_mark = string.index('?')
    with_dot = string.dup
    with_dot[first_question_mark] = '.'
    with_hash = string.dup
    with_hash[first_question_mark] = '#'
    # puts "#{string}: #{with_dot} #{with_hash}"
    alternatives_for(with_dot) + alternatives_for(with_hash)
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
end