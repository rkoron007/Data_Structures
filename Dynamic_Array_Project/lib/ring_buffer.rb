require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    @length = 0
    @capacity = capacity
    @start_index = 0
    @store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_index + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_index + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    # last_el = @store[(@start_index + @length) % @capacity]
    @length -= 1
  end

  # O(1) ammortized
  def push(val)
    self.resize! if @capacity == @length
    @length += 1
    @store[@length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    self[0] = nil
    @start_index = (@start_index + 1) % @capacity
    @length -= 1
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if @capacity == @length
    @start_index = (@start_index - 1) % capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length


  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end
