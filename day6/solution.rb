class Race
  attr_reader :time, :distance
  def initialize(time, distance)
    @time = time
    @distance = distance
  end

  def ==(another)
    time == another.time && distance == another.distance
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