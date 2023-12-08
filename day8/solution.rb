class NetworkMap
  INITIAL_NODE = 'AAA'
  FINAL_NODE = 'ZZZ'

  attr_reader :nodes, :current_instruction, :moves
  def initialize(map_doc)
    instructions_doc, nodes_doc = map_doc.split("\n\n")
    @nodes = parse_nodes(nodes_doc)
    @current_instruction = parse_instructions(instructions_doc)
    @moves = 0
    @current_node = INITIAL_NODE
  end

  def move!
    return false if finished?
    next_node = nodes[@current_node][@current_instruction.index_value]
    @current_instruction = @current_instruction.next
    @moves += 1
    @current_node = next_node
    true
  end

  def complete!
    while move! do
      true
    end
  end

  private
  def finished?
    @current_node == FINAL_NODE
  end
  def parse_nodes(doc)
    h = {}
    doc.split("\n").each do |line|
      name, exits_doc = line.split(" = ")
      exits = exits_doc.split('(')[1].split(')')[0].split(', ')
      h[name] = exits
    end
    h
  end

  def parse_instructions(doc)
    instruction_values = doc.split('')
    instructions = instruction_values.map do |value|
      Instruction.new(value)
    end
    instructions.each_with_index do |instruction, index|
      next_index = index + 1 >= instructions.length ? 0 : index + 1
      instruction.next = instructions[next_index]
    end
    instructions.first
  end
end

class NetworkMapMultiplePath < NetworkMap

  def initialize(map_doc)
    instructions_doc, nodes_doc = map_doc.split("\n\n")
    @nodes = parse_nodes(nodes_doc)
    @current_instruction = parse_instructions(instructions_doc)
    @moves = 0
    @current_nodes = initial_nodes
  end

  def move!
    return false if finished?
    next_nodes = @current_nodes.map { |current_node| nodes[current_node][@current_instruction.index_value] }
    @current_instruction = @current_instruction.next
    @moves += 1
    @current_nodes = next_nodes
    true
  end

  private
  def initial_nodes
    @nodes.keys.select { |k| k[-1] == 'A' }
  end

  def finished?
    @current_nodes.inject(true) { |memo, node| memo && node[-1] == 'Z' }
  end


end

class Instruction
  attr_accessor :value, :next

  INDEX_VALUES = {
    'R' => 1,
    'L' => 0,
  }

  def initialize(value)
    @value = value
  end

  def next=(another)
    @next = another
  end

  def index_value
    INDEX_VALUES[value]
  end
end

if __FILE__ == $PROGRAM_NAME
  doc = File.read("input.txt")
  network_map = NetworkMap.new(doc)
  network_map.complete!
  puts network_map.moves

  multiple_network_map = NetworkMapMultiplePath(doc)
  multiple_network_map.complete!
  puts multiple_network_map.moves
end