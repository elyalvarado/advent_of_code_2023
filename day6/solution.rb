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

    # If we find exact solutions they don't count as they don't beat the time
    solution2 = solution2 + 1 if solution2.ceil.to_f == solution2
    solution1 = solution1 - 1 if solution1.floor.to_f == solution1
    (solution2.ceil..solution1.floor).to_a
  end
end

class RaceCollection
  attr_reader :races

  def total_options
    races.map(&:beat_options).map(&:size).inject(:*)
  end
end

class MultipleRaces < RaceCollection
  def initialize(doc)
    times, distances = doc.split("\n")
                          .map { |line| line.split(":")[1] }
                          .map { |line| line.split(" ") }
    @races = []
    times.each_with_index do |time, index|
      races << Race.new(time.to_i, distances[index].to_i )
    end
    @races
  end
end

class SingleRace < RaceCollection
  def initialize(doc)
    time, distance = doc.split("\n")
                          .map { |line| line.split(":")[1] }
                          .map { |line| line.split(" ").join.to_i }
    @races = [ Race.new(time, distance) ]
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read("input.txt")
  races = MultipleRaces.new(doc)
  puts races.total_options

  single_race = SingleRace.new(doc)
  puts single_race.total_options
end