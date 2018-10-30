class Node

    attr_reader :right, :value, :left

    def initialize(value: 0, node: nil, left: nil, right: nil, length: 1)
        if !node.nil?
            @right = node.right
            @left = node.left
            @value = node.value
        else
            @right = right
            @left = left
            @value = value
        end
    end

    def <=>(other)
        @value <=> other.value
    end
end

class ImmutableHeap
    attr_accessor :root, :size

    def initialize(array: [], root: nil, size: 0)
        @root = root
        @size = size
        if root.nil?
            @root = heapify(array)
        end
    end

    def smaller(a, b)
        (a <=> b) < 0
    end

    def stack_to_last(length)
        bin = length.to_s(2)
        node = @root
        stack = []
        bin = bin[1..-1]
        bin.each_char do |c|
            if c == "0"
                next_node = node.right
                next_dir = :right
            else
                next_node = node.left
                next_dir = :left

            end
            stack.unshift([node, next_dir])
            node = next_node
            if next_node.nil?
                break
            end
        end
        stack
    end

    def heapify(array)
        @size = array.length
        loop = -> (i) do
            if i < array.length
                return bubble_down(Node.new(value: array[i], right: loop.call(2 * i + 1), left: loop.call(2 * i + 2)))
            else
                return nil
            end
        end
        return loop.call(0)
    end

    def push(value)
        node = Node.new(value: value)
        return ImmutableHeap.new(root: node, size: 1) if @root.nil?
        stack = stack_to_last(@size + 1)
        res = bubble_up(node, stack)
        ImmutableHeap.new(root: res, size: @size + 1)
    end

    def bubble_up(node, stack)
        res = node
        while stack.length > 0 do
            x = stack[0]
            if smaller(res, x[0])
                stack.shift
                res = swap_nodes(res, x[0], x[1])
            else
                break
            end
        end
        update_parents(res, stack)
    end


    def peek
        @root.value
    end

    def pop
        return nil if @size == 0
        value = @root.value
        stack = stack_to_last(@size)
        if stack.empty?
            return value, ImmutableHeap.new
        end
        if stack[0][1] == :right
            last = stack[0][0].right.nil? ? stack[0][0] : stack[0][0].right
        else
            last = stack[0][0].left.nil? ? stack[0][0] : stack[0][0].left
        end
        updated = update_parents(nil, stack)
        new_root = Node.new(value: last.value, left: updated.left, right: updated.right)

        [value, ImmutableHeap.new(root: bubble_down(new_root), size: @size - 1)]
    end

    def update_parents(node, stack)
        res = node
        stack.each do |x|
            res = update_parent(res, x[0], x[1])
        end
        res
    end

    def update_parent(child, parent, direction)
        if direction == :right
            Node.new(value: parent.value, right: child, left: parent.left)
        else
            Node.new(value: parent.value, right: parent.right, left: child)
        end
    end

    def bubble_down(node)
        stack = []
        res = node
        while true
            mc, direction = min_child(res)
            if mc.nil?
                break
            end
            if (res <=> mc) > 0
                new_node = swap_nodes(mc, res, direction)
                stack.unshift([new_node, direction])
                if direction == :right
                    res = new_node.right
                elsif direction == :left
                    res = new_node.left
                end
            else
                break
            end
        end
        if stack.empty?
            node
        else
            update_parents(res, stack)
        end
    end

    def min_child(node)
        if node.right.nil? && node.left.nil?
            return nil, nil
        elsif node.left.nil?
            return node.right, :right
        elsif node.right.nil?
            return node.left, :left
        end
        if smaller(node.right, node.left)
            [node.right, :right]
        else
            [node.left, :left]
        end
    end

    def swap_nodes(node, parent, direction)
        new_child = Node.new(value: parent.value, left: node.left, right: node.right)
        if direction == :left
            Node.new(value: node.value, left: new_child, right: parent.right)
        else
            Node.new(value: node.value, left: parent.left, right: new_child)
        end
    end

end