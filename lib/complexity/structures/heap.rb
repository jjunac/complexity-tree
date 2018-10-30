class Node
    def initialize(value, right: nil, left: nil)
        @right = right
        @left = left
        @value = value
    end
end

class Heap

    def name;
        "BinaryHeap"
    end


    def initialize(array: [])
        @compare = ->(a, b) {(a <=> b) < 0}
        heapify(array)
    end

    def heapify(array)
        @heap = [0] + array.clone
        i = array.length / 2
        @last = array.length
        i.downto(1).each {|x| bubble_down(x)}
    end

    def push(value)
        @last += 1
        @heap[@last] = value
        bubble_up(@last)
        self
    end

    def peek
        @heap[1]
    end

    def pop
        return nil if @last == 0
        value = @heap[1]
        @heap[1] = @heap[@last]
        @last -= 1
        bubble_down(1)
        [value, self]
    end

    def size
        @last
    end

    def bubble_up(child)
        return if child == 1
        parent_index = parent(child)
        if @compare[@heap[child], @heap[parent_index]]
            temp = @heap[child]
            @heap[child] = @heap[parent_index]
            @heap[parent_index] = temp
            bubble_up(parent_index)
        end
    end

    # def bubble_down(parent_index)
    #     return if parent_index > parent(@last)
    #     left = left_child(parent_index)
    #     right = right_child(parent_index)
    #
    #     if right > @last
    #         child = left
    #     else
    #         child = @compare[@heap[left], @heap[right]] ? left : right
    #     end
    #
    #     if @compare[@heap[child], @heap[parent_index]]
    #         temp = @heap[child]
    #         @heap[child] = @heap[parent_index]
    #         @heap[parent_index] = temp
    #         bubble_down(child)
    #     end
    # end

    def bubble_down(i)
        while (left_child(i)) <= @last
            mc = self.min_child(i)
            if @heap[i] > @heap[mc]
                tmp = @heap[i]
                @heap[i] = @heap[mc]
                @heap[mc] = tmp
            end
            i = mc
        end
    end

    def min_child(i)
        if right_child(i) > @last
            return left_child(i)
        else
            if @heap[left_child(i)] < @heap[right_child(i)]
                return left_child(i)
            else
                return right_child(i)
            end
        end
    end

    def parent(index)
        index / 2
    end

    def left_child(index)
        2 * index
    end

    def right_child(index)
        2 * index + 1
    end
end