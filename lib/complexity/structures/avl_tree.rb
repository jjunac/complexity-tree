class AVLTree

    attr_accessor :value, :left, :right, :height

    def initialize(value=nil)
        @value = value
        @left = nil
        @right = nil
        @height = 0
    end

    def to_s
        return "(#{@left.to_s}) #{value} (#{@right.to_s})"
    end

    def left_height
        return @left.nil? ? -1 : @left.height
    end

    def right_height
        return @right.nil? ? -1 : @right.height
    end

    def update_height
        @height = 1 + [left_height, right_height].max
    end

    def left_rotate
        p "left_rotate"
        tmp = @right
        @right = tmp.right
        @value, tmp.value = tmp.value, @value
        tmp.right, tmp.left = tmp.left, @left
        @left = tmp
    end

    def right_rotate
        p "right_rotate"
        tmp = @left
        @left = tmp.left
        @value, tmp.value = tmp.value, @value
        tmp.left, tmp.right = tmp.right, @right
        @right = tmp
    end

    def push(v)
        # Eliminate empty tree case
        if @value.nil?
            @value = v
            return
        end
        # Recursive push
        if v < @value
            if @left.nil?
                @left = AVLTree.new v
            else
                @left.push(v)
            end
        else
            if @right.nil?
                @right = AVLTree.new v
            else
                @right.push(v)
            end
        end
        update_height
        balance = left_height - right_height
        p to_s
        p balance
        # Left Left
        if balance > 1 and @value < @left.value
            right_rotate
        end
        # Right Right
        if balance < -1 and @value > @right.value
            left_rotate
        end
        # Left Right
        if balance > 1 and @value > @left.value
            p to_s
            left.left_rotate
            p to_s
            right_rotate
            p to_s
        end
        # Right Left
        if balance < -1 and @value < @right.value
            right.right_rotate
            left_rotate
        end
    end

    def pop()
        # Eliminate empty tree case
        if @value.nil?
            return nil
        end
        # Recursive pop
        if @left.nil?
            tmp = @value
            if @right.nil?
                @value = nil
            else
                @value = @right.value
                @right = nil
            end
            return tmp
        else
            if @left.value.nil?
                @left = nil
            end
        end
    end


end