require 'algorithms'
class FibonacciHeap

    def name;
        "FibonacciHeap"
    end

    def initialize(array: [])
        @heap = Containers::Heap.new array
    end

    def pop
        [@heap.pop, self]
    end

    def push(n)
        @heap.push n
        self
    end

    def min
        @heap.next
    end
end