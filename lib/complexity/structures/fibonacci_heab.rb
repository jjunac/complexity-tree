class FibonacciHeap

    def name; "FibonacciHeap" end

    def initialize
        @heap = Containers::Heap.new
    end

    def pop
        @heap.next!
    end

    def push(n)
        @heap << n
    end

    def min
        @tree.next
    end

end