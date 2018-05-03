class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc ||= Proc.new { |x, y| x <=> y }
    @store = []
  end

  def count
    store.length
  end

  def extract
    bottom = @store[0]
    if count > 1
      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, &@prc)
    else
      @store.pop
    end

    bottom
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    #given parent need to (2*parent_idx) + 1
    children = []
    first_child = ((2 * parent_index) + 1)
    second_child = ((2 * parent_index) + 2)
    children << first_child if first_child < len
    children << second_child if second_child < len
    children
  end

  def self.parent_index(child_index)
    #given child-> child_index - 1 / 2
    raise "root has no parent" if child_index == 0
    return (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    child_indexs = self.child_indices(len, parent_idx)

    if child_indexs.all? { |child| prc.call(array[parent_idx], array[child]) <= 0 }
      return array
    end

    if child_indexs.length == 1
      swap_index = child_indexs.first
    else
      child_values = [array[child_indexs[0]], array[child_indexs[1]]]
       if prc.call(child_values[0], child_values[1]) == -1
         swap_index = child_indexs[0]
       else
         swap_index = child_indexs[1]
       end
    end

    array[parent_idx], array[swap_index] = array[swap_index], array[parent_idx]
    self.heapify_down(array, swap_index, len, &prc)
  end

  def self.heapify_up(array, child_index, len = array.length, &prc)
    return array if child_index == 0
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    # check child against parent and swap elements if the parent is greater
    parent_index = parent_index(child_index)

    if prc.call(array[parent_index], array[child_index]) <= 0
      return array
    end

    parent_val = array[parent_index]

    array[parent_index], array[child_index] = array[child_index], array[parent_index]
    self.heapify_up(array, parent_index, len, &prc)
  end
end
