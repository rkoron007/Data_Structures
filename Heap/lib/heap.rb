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
    #save the bottom
    bottom = @store[0]

    #if store's length > 1
    if count > 1
      #reassign the front to be the bottom we just popped off
      @store[0] = @store.pop

      #then we need to reheap don the line and make sure we are in order
      BinaryMinHeap.heapify_down(@store, 0, &@prc)
    else
      #otherwise we are just empty!
      @store.pop
    end
    
    #return that bottom node
    bottom
  end

  def peek
    @store[0]
    #this is always the first val
  end

  def push(val)
    #so we push the val onto our end
    @store.push(val)
    # then we call our class method to re-heap ourselves and make sure
    # maintaining heap order

    # We know our new tail is our end so hand off our length -1
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
    #set proc to go autp down if don't have proc
    prc ||= Proc.new { |x, y| x <=> y }
    #find my child indexs
    child_indexs = self.child_indices(len, parent_idx)

    #if my child indexes pass the test then we are done heaping here
    if child_indexs.all? { |child| prc.call(array[parent_idx], array[child]) <= 0 }
      return array
    end

    #at this point we know we need to make a swap,
    if child_indexs.length == 1
      #if we only have on child we know thats our swap point
      swap_index = child_indexs.first
    else
      #if we have two children we need to find which one is smaller
      #(or follows the proc)
      #so we find values for both children then find which one is "smaller"
      child_values = [array[child_indexs[0]], array[child_indexs[1]]]
       if prc.call(child_values[0], child_values[1]) == -1
         swap_index = child_indexs[0]
       else
         swap_index = child_indexs[1]
       end
    end

    #so we know which one is smaller so its time to swap
    array[parent_idx], array[swap_index] = array[swap_index], array[parent_idx]
    # we made our swap -> now we know we can continue down
    # the line with our children
    self.heapify_down(array, swap_index, len, &prc)
  end

  def self.heapify_up(array, child_index, len = array.length, &prc)
    # if we are at our root (going right to left) we know that we don't
    # have any parents so we can heap back up
    return array if child_index == 0

    #create our default order if don't have
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    #find our parent index
    parent_index = parent_index(child_index)

    #if the value at ur parent
    #index is less than our current value we are good!
    #we don't have to swap
    if prc.call(array[parent_index], array[child_index]) <= 0
      return array
    end

    # so we know at this point our child is greater
    # so we need to swap

    array[parent_index], array[child_index] = array[child_index], array[parent_index]
    # so at this point we know we need to keep moving up the chain
    # So we hand off our parent index to go up the chain
    self.heapify_up(array, parent_index, len, &prc)
  end
end
