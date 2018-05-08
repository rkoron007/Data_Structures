class Vertex
  attr_accessor :value, :in_edges, :out_edges

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex, @to_vertex = from_vertex, to_vertex
    @cost = cost

    add_self_to_vertex
  end

  def add_self_to_vertex
    @from_vertex.out_edges.push(self)
    @to_vertex.in_edges.push(self)
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_edges.delete(self)

    @from_vertex, @to_vertex = nil, nil
  end
end
