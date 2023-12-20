
class CrucibleMap
  Position = Struct.new(:node, :path)
  Distance = Struct.new(:length, :limited)
  def initialize(doc)
    @matrix = doc.split("\n").map { |line| line.split('').map(&:to_i) }
    @height = @matrix.size
    @width = @matrix.first.size
  end

  def minimal_heat_loss(initial_position: [0,0])
    queue = PriorityQueue.new
    distances = @matrix.map { |line| Array.new(line.size,Distance.new(Float::INFINITY, false)) }
    visited = @matrix.map { |line| Array.new(line.size, false) }
    destination = [@height - 1, @width - 1]
    # recently_visited = [ nil, nil, nil ]

    queue.enqueue(Position.new(initial_position, [initial_position]), 0)
    distances[initial_position[0]][initial_position[1]] = Distance.new(0, false)

    until queue.empty? do
      current = queue.dequeue
      u = current.node
      # if u[0] == destination[0] && u[1] == destination[1]
      #   puts "Reached target node #{u}"
      #   puts "Path:\n#{current.path.inspect}"
      # end
      next if visited[u[0]][u[1]]
      puts "Checking #{u.inspect} (path: #{current.path.inspect})"
      adjacent_nodes_with_weight, limited = adjacent(current)
      puts "Adjacent nodes: #{adjacent_nodes_with_weight.inspect}"
      puts "limited: #{limited}"
      visited[u[0]][u[1]] = !limited
      puts "Visiting #{u.inspect}." if !limited
      puts "Checking but not marking as visited #{u.inspect}" if limited

      path = current.path
      shortest_distance_to_u = distances[u[0]][u[1]].length
      puts "Current distance: #{shortest_distance_to_u}"
      adjacent_nodes_with_weight.each do |node_weight|
        v, w = node_weight
        v_has_not_been_visited = !visited[v[0]][v[1]]
        shortest_distance_to_v = distances[v[0]][v[1]].length
        shortest_distance_to_v_was_limited = distances[v[0]][v[1]].limited
        current_distance_to_v = shortest_distance_to_u + w
        use_current_distance = shortest_distance_to_v_was_limited ? current_distance_to_v <= shortest_distance_to_v : current_distance_to_v < shortest_distance_to_v
        if v_has_not_been_visited && use_current_distance
          distances[v[0]][v[1]] = Distance.new(current_distance_to_v, limited)
          queue.enqueue(Position.new(v, path + [v]), current_distance_to_v)
        end
      end
      puts "After trying to visit adjacents"
      puts queue.inspect
      puts '---'
    end

    distances.map { |line| puts line.map(&:length).join("\t") }

    distances[@height-1][@width-1].length
  end

  private
  TRAVEL_DELTAS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]
  def adjacent(position)
    # puts "Calculating adjancent for position: #{position.inspect}"
    limited = false
    node = position.node
    path = position.path
    previous_node = path.size >= 2 ? path.last(2).first : nil
    excluded_deltas = []
    excluded_deltas.push([-1,0]) if node[0] == 0 # Can't go over the top
    excluded_deltas.push([0,-1]) if node[1] == 0 # Can't go over the left
    excluded_deltas.push([1,0]) if node[0] == (@height - 1) # Can't go over the bottom
    excluded_deltas.push([0,1]) if node[1] == (@width - 1) # Can't go over the right
    excluded_deltas.push([previous_node[0]-node[0],previous_node[1]-node[1]]) if previous_node # Can't go back

    recently_visited = path.last(4).reverse
    if recently_visited.size == 4
      recent_deltas = []
      (recently_visited.size - 1).times do |i|
        recent_deltas << [recently_visited[i][0]-recently_visited[i+1][0],recently_visited[i][1]-recently_visited[i+1][1]]
      end
      excluded_deltas.push(recent_deltas.first) if recent_deltas.uniq.size == 1 # we have been going in the same direction 3 times in a row
      limited = true if recent_deltas.uniq.size == 1
    end

    adj = (TRAVEL_DELTAS - excluded_deltas).map do |delta|
      line = node[0] + delta[0]
      row = node[1] + delta[1]
      [[line,row], @matrix[line][row]]
    end

    if node[0] == 1 && node[1] == 2
    #   puts "Adjancent for #{node.inspect} (path: #{path.inspect})"
    #   puts "Excluded deltas: #{excluded_deltas}"
    #   puts "recent deltas: #{recent_deltas}"
    #   puts "Available deltas: #{TRAVEL_DELTAS - excluded_deltas}"
    #   puts "Adjancent: #{adj}"
    #   puts "Limited: #{limited}"
    end

    [adj,limited]
  end
end

class PriorityQueue
  def initialize
    @queue = []
  end

  def enqueue(element, priority)
    # puts "Enqueue"
    # puts "  Current queue: #{@queue.inspect}"
    # puts "  element: #{element}, priority: #{priority}"
    @queue << { element: element, priority: priority }
    @queue.sort! { |a,b| a[:priority] <=> b[:priority] }
  end

  def dequeue
    return nil if @queue.empty?
    @queue.shift[:element]
  end

  def empty?
    @queue.empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read('input.txt')
end