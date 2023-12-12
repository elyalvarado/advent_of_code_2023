class SpringsMap
  attr_reader :springs
  def initialize(doc)

  end
end

class Spring
  def initialize(doc)
    @og_string, groups = doc.split(' ')
    @groups = groups.split(',').map(&:to_i).sort
  end

  def arrangements

  end

  private
  def alternatives
    @alternatives ||= alternatives_for(@og_string)
  end

  def alternatives_for(string)
    return [ string ] unless string.include('?')
    first_question_mark = string.index('?')
    with_dot = string.dup
    with_dot[first_question_mark] = '.'
    with_question_mark = string.dup
    with_question_mark[first_question_mark] = '?'
    alternatives_for(with_dot) + alternatives_for(with_question_mark)
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
end