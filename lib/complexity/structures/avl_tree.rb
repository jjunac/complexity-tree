class AVLTree

    attr_accessor :value, :left, :right, :height

    def initialize(value = nil, array: [])
        @value = value
        @left = nil
        @right = nil
        @height = 0
        array.sort!
        array.each do |x|
            push(x)
        end
    end

    def print(offset = 0)
        puts "#{"  " * offset}`-#{value} {balance=#{balance}, height=#{height}, left=#{@left}, right=#{@right}}"
        @left.print offset + 1 unless @left.nil?
        @right.print offset + 1 unless @right.nil?
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

    def balance
        return left_height - right_height
    end

    def left_rotate
        tmp = @right
        @right = tmp.right
        @value, tmp.value = tmp.value, @value
        tmp.right, tmp.left = tmp.left, @left
        @left = tmp
        @left.update_height
        update_height
    end

    def right_rotate
        tmp = @left
        @left = tmp.left
        @value, tmp.value = tmp.value, @value
        tmp.left, tmp.right = tmp.right, @right
        @right = tmp
        @right.update_height
        update_height
    end

    def push(v)
        # Eliminate empty tree case
        if @value.nil?
            @value = v
            return self
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
        # Left Left
        if balance > 1 and @left.balance >= 0
            right_rotate
        end
        # Right Right
        if balance < -1 and @right.balance <= 0
            left_rotate
        end
        # Left Right
        if balance > 1 and @left.balance < 0
            @left.left_rotate
            right_rotate
        end
        # Right Left
        if balance < -1 and @right.balance > 0
            @right.right_rotate
            left_rotate
        end
        self
    end

    def pop()
        # Eliminate empty tree case
        if @value.nil?
            return nil
        end
        res = nil
        # Recursive pop
        if @left.nil?
            res = @value
            if @right.nil?
                @value = nil
            else
                @value = @right.value
                @right = nil
            end
        else
            if @left.left.nil?
                # Left is the min
                res = @left.value
                @left = @left.right
            else
                res = @left.pop
            end
        end
        update_height
        # Left Left
        if balance > 1 and @left.balance >= 0
            right_rotate
        end
        # Right Right
        if balance < -1 and @right.balance <= 0
            left_rotate
        end
        # Left Right
        if balance > 1 and @left.balance < 0
            @left.left_rotate
            right_rotate
        end
        # Right Left
        if balance < -1 and @right.balance > 0
            @right.right_rotate
            left_rotate
        end
        return res,self
    end
end