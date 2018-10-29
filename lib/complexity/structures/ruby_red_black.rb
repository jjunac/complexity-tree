class RubyRedBlack

    def initialize(array: [])
        @tree = Containers::RubyRBTreeMap.new
        array.sort!
        array.each do |x|
            @tree.push(x, x)
        end
    end

    def pop
        [@tree.delete_min, self]
    end

    def push(n)
        @tree.push(n, n)
        self
    end

    def min
        @tree.min_key
    end

    def max
        @tree.max_key
    end

end