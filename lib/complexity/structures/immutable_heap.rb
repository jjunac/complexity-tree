class Node

  attr_reader :right, :value, :length, :left

  def initialize(value: 0, node: nil, left: nil, right: nil, length: 1)
    if !node.nil?
      @right = node.right
      @left = node.left
      @value = node.value
      @length = node.length
    else
      @right = right
      @left = left
      @value = value
      @length = length
    end
  end

  def <=>(other)
    @value <=> other
  end
end

class ImmutableHeap
  def initialize(array: [])
    @compare = ->(a, b) {(a <=> b) < 0}
    @root = nil
    @size = 0
    heapify(array)
  end


  def stackify(length)
    bin = length.to_s(2)
    node = @root
    stack = []
    bin = bin[1..-1]
    bin.each_char do |c|
      if c == "1"
        nex = [node.right, :right]
      else
        nex = [node.left, :left]
      end
      if nex.nil?
        break
      end
      stack.unshift(node)
      node = nex
    end
    stack
  end

  def heapify(array)
    i = floor(array.length / 2)
    @last = @heap.length
    @heap = array.clone
    i.downto(1).each {|x| bubble_down(x)}
  end

  def push(node)
    stack = stackify(@root.length + 1)
    bubble_up(node, stack)
  end

  def peek
    @root.value
  end

  def pop
    return nil if @last == 0
    value = @heap[1]
    @heap[1] = @heap[@last]
    @last -= 1
    bubble_down(1)
    value
  end

  def size
    @last
  end

  def update_parents(node, stack)
    parent = stack[0]
    old = update_nodes(node, parent[0], parent[1])
    stack.each do |x|
      res = update_nodes(x[0], old, x[1])
    end
    res
  end

  def bubble_up(node, stack)
    i = 0
    stack.each do |x|
      if !@compare[node, x]
        swap_nodes(node, x)
      end
      i += 1
    end
    stack[i]
  end

  def bubble_down(node)
    return if node > parent(@last)
    left = node.left
    right = node.right

    if right > @last
      child = left
    else
      child = @compare[@heap[left], @heap[right]] ? left : right
    end

    if @compare[@heap[child], @heap[node]]
      temp = @heap[child]
      @heap[child] = @heap[node]
      @heap[node] = temp
      bubble_down(child)
    end

  end

  def update_nodes(parent, child, direction)
    if direction == :right
      Node.new(value: parent.value, right: child, left: parent.left)
    else
      Node.new(value: parent.value, right: parent.right, left: child)
    end
  end

  def swap_nodes(node, parent, direction)
    new_child = Node.new(value: parent.value, left: nil, right: nil)
    if direction == :left
      Node.new(value: node.value, left: new_child, right: parent.right)
    else
      Node.new(value: node.value, left: parent.left, right: new_child)
    end
  end

end