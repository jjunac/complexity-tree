class RubyRedBlack

    def initialize
        @tree = Containers::RubyRBTreeMap.new
    end

    def pop
        @tree.delete_min
    end

    def push(n)
        @tree.push(n, n)
    end

    def min
        @tree.min_key
    end

    def max
        @tree.max_key
    end

end