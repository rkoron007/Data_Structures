require_relative 'graph'
require 'byebug'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms
# O(|v| + |e|)
def topological_sort(vertices)
  #Khan's
  sorted = []
  top = []
  has_in_edges = {}

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


#Tarjan's Algo

def tarjan_topo
  order = []
  explored = Set.new

  vertices.each do |vertex|
    dfs!(order,explored,vertex) unless explored.include?(vertex)

  end

  order
end

def dfs!(order,explored,vertex)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertext = edge.to_vertex
    dfs!(order,explored,to_vertext) unless explored.include?(to_vertext)
  end

  order.unshift(vertex)
end


#
