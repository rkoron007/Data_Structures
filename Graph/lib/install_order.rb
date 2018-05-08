# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative "graph"
require_relative "topological_sort"
require "byebug"

def install_order(arr)
  max_value = 0
  current_verticies = Hash.new

  arr.each do |tuple|
    tuple.each do |number|
      if current_verticies.keys.include?(number)
        next
      else
        max_value = number if number > max_value

        current_verticies[number] = Vertex.new(number)
      end
    end

    Edge.new(current_verticies[tuple[0]], current_verticies[tuple[1]])
  end

  range = (1..max_value)
  current_numbers = current_verticies.keys

  extras = range.reject{|el| current_numbers.include?(el)}
  if extras
    extras.each do |el|
      current_verticies[el] = Vertex.new(el)
    end
  end
  arr = topological_sort(current_verticies.values)


end
