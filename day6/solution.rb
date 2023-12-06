class Race
  attr_reader :time, :distance
  def initialize(time, distance)
    @time = time
    @distance = distance
  end

  def ==(another)
    time == another.time && distance == another.distance
  end
  def beat_options
    # time is the total time
    # speed = push_time
    # distance = travel_time * speed
    # time = push_time + travel_time
    # travel_time = time - push_time
    # distance = (time - push_time) * push_time
    # distance = time*push_time - push_time^2
    # Quadratic equation to solve becomes
    # -push_time^2 + time*push_time - distance
    # where a = -1, b = time, c = -distance
    # solutions are: (-b +/- Math.sqrt(b^2-4*a*c))/(2*a)
    solution1 = (-1 * time - Math.sqrt(time**2 - 4 * distance))/-2
    solution2 = (-1 * time + Math.sqrt(time**2 - 4 * distance))/-2
    (solution2.ceil..solution1.floor).to_a
  end

  def self.parse_races(doc)
    times, distances = doc.split("\n")
                          .map { |line| line.split(":")[1] }
                          .map { |line| line.split(" ") }
    races = []
    times.each_with_index do |time, index|
      races << Race.new(time.to_i, distances[index].to_i )
    end
    races
  end
end


if __FILE__ == $PROGRAM_NAME
  # doc = File.read("input.txt")
end