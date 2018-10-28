class ImmutableAVLTree

  attr_accessor :value, :left, :right, :height

  def initialize(value=nil)
    @value = value
    @left = nil
    @right = nil
    @height = 0
  end

  def print(offset=0)
    puts "#{"  "*offset}`-#{value} {balance=#{balance}, height=#{height}, left=#{@left}, right=#{@right}}"
    @left.print offset+1 unless @left.nil?
    @right.print offset+1 unless @right.nil?
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
      return ImmutableAVLTree.new v
    end
    # Recursive push
    new_root = ImmutableAVLTree.new @value
    if v < @value
      new_root.right = @right
      if @left.nil?
        new_root.left = ImmutableAVLTree.new v
      else
        new_root.left = @left.push(v)
      end
    else
      new_root.left = @left
      if @right.nil?
        new_root.right = ImmutableAVLTree.new v
      else
        new_root.right = @right.push(v)
      end
    end
    new_root.update_height
    # Left Left
    if new_root.balance > 1 and new_root.left.balance >= 0
      new_root.right_rotate
    end
    # Right Right
    if new_root.balance < -1 and new_root.right.balance <= 0
      new_root.left_rotate
    end
    # Left Right
    if new_root.balance > 1 and new_root.left.balance < 0
      new_root.left.left_rotate
      new_root.right_rotate
    end
    # Right Left
    if new_root.balance < -1 and new_root.right.balance > 0
      new_root.right.right_rotate
      new_root.left_rotate
    end
    return new_root
  end

  def pop()
    # Eliminate empty tree case
    if @value.nil?
      return nil, ImmutableAVLTree.new
    end
    new_root = nil
    res = nil
    # Recursive pop
    if @left.nil?
      res = @value
      if @right.nil?
        new_root = ImmutableAVLTree.new
      else
        new_root = ImmutableAVLTree.new @right.value
      end
    else
      new_root = ImmutableAVLTree.new @value
      new_root.right = @right
      if @left.left.nil?
        # Left is the min
        res = @left.value
        new_root.left = @left.right
      else
        res, new_root.left = @left.pop
      end
    end
    new_root.update_height
    # Left Left
    if new_root.balance > 1 and new_root.left.balance >= 0
      new_root.right_rotate
    end
    # Right Right
    if new_root.balance < -1 and new_root.right.balance <= 0
      new_root.left_rotate
    end
    # Left Right
    if new_root.balance > 1 and new_root.left.balance < 0
      new_root.left.left_rotate
      new_root.right_rotate
    end
    # Right Left
    if new_root.balance < -1 and new_root.right.balance > 0
      new_root.right.right_rotate
      new_root.left_rotate
    end
    return res, new_root
  end
end