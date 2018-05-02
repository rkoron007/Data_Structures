require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @start_index = 0
    @length = 0
    @capacity = capacity
    @store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  def capacity
    @store.length
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    last = @store[(@start_index + @length - 1)]
    @length -= 1
    last
  end


  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @capacity == @length
    @store[(@start_index + @length)] = val
    @length += 1
    self
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(@length)
    @length -= 1
    first = @store[0]
    (0..@length).each_with_index {|el, i| @store[i-1] = el}
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if @capacity == @length
    @length += 1
    (0..@length).each_with_index {|el, i| @store[i+1] = el}
    @store[0] = val
    self
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end


  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)

    i = 0
    while i < @length
      new_store[i] = self[i]
      i += 1
    end
    @store = new_store
    @start_idx = 0
  end
end
