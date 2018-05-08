require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms
# O(|v| + |e|)
def topological_sort(vertices)
  #Khan's
  has_in_edges = {}
  sorted = []
  top = []

  # O(|v|) time
  #take vertex if it has no in-edges
  vertices.each do |vertex|
    has_in_edges[vertex] = vertex.in_edges.length
    if vertex.in_edges.empty?
      top.push(vertex)
    end
  end

  # O(|e| set) time
  until top.empty?
    current = top.shift
    sorted.push(current)
    current.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      has_in_edges[to_vertex] -= 1
      if has_in_edges[to_vertex] == 0
        top.push(to_vertex)
      end

    end

  end
  return sorted if sorted.length == vertices.length
  []
end


#
