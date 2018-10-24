class AVLTree

    attr_accessor :value, :left, :right, :height

    def initialize
        @value = value
        @left = nil
        @right = nil
        @height = 0
    end

    def update_height
        @height = 1 + [@left.height, @right.height].max
    end

    def left_rotate
        next_root = @right
        tmp = next_root.left
        # Perform rotation 
        next_root.left = self
        @right = tmp
        # Update heights 
        update_height
        next_root.update_height
    end

    def right_rotate
        next_root = @left
        tmp = next_root.right
        # Perform rotation 
        next_root.right = self
        @left = tmp
        # Update heights 
        update_height
        next_root.update_height
    end

    def push(v)
        # Eliminate empty tree case
        if @nil?
            if @root.nil?
                @root = Node.new v
            else
                # Start recursive push
                push(v, @root)
            end
            return
        end
        # Recursive push
        if v < @value
            if @left.nil?
                @left = Node.new v
            else
                push(v, @left)
            end
        else
            if @right.nil?
                @right = Node.new v
            else
                push(v, @right)
            end
        end
        update_height
        balance = @left.height - @right.height
            # Left Left 
            if balance > 1 and @value < @left.value 
                right_rotate 
        
            # Right Right 
            if balance < -1 and @value > @right.value 
                left_rotate 
        
            # Left Right 
            if balance > 1 and @value > @left.value 
                left_rotate(@left) 
                right_rotate 
        
            # Right Left 
            if balance < -1 and @value < @right.value 
                right_rotate(@right) 
                left_rotate 
    end

    def pop(n=nil)
        # Eliminate empty tree case
        if @nil?
            if @root.nil?
                return nil
            else
                # Start recursive pop
                return pop(@root)
            end
        end
        # Recursive pop
        if @left.nil?
            tmp = @value
            @value = @right.value

        end
    end


end