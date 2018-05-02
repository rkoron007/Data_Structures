
class Node

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @prev = nil
    @next = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end

  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |current_node|
      if current_node.key == key
        return current_node.val
      end
    end
  end

  def include?(key)
    each do |current_node|
      if current_node.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node

    new_node
  end

  def update(key, val)
    each do |current_node|
      if current_node.key = key
        current_node.val = val
      end
    end
  end

  def remove(key)
    each do |current_node|
      if current_node.key == key
        current_node.remove
        return current_node.val
      end
    end
    nil
  end

  def each
    current = @head.next
    until current == @tail
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
