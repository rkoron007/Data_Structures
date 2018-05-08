# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative "graph"
require_relative "topological_sort"

def install_order(arr)
  max_value = 0
  current_verticies = Hash.new

  arr.each do |tuple|

    vertices[tuple[0]] = Vertex.new(tuple[0]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(tuple[1]) unless vertices[tuple[1]]
    Edge.new(current_verticies[tuple[1]], current_verticies[tuple[0]])

    max_value = tuple.max if tuple.max > max_value
  end

  range = []
  (1..max_value).each do |i|
    range << i unless current_verticies[i]
  end

  range + topological_sort(current_verticies.values).map {|v| v.value}
end
