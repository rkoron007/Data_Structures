class BSTNode

  attr_accessor :left, :right, :parent
  attr_reader :value
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end
