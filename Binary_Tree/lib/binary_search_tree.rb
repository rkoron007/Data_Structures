require_relative "bst_node"
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root
  def initialize(root = nil)
    @root = root
    @depth = 1
  end

  def insert(value)
    if @root
      self.class.insert!(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value)
    self.class.find!(@root, value)
  end

  def delete(value)
    @root = self.class.delete!(@root, value)
  end

  def self.insert!(node_parent, value)
    if node_parent.nil?
      return BSTNode.new(value)
    elsif value <= node_parent.value
      node_parent.left = insert!(node_parent.left, value)
    else
      node_parent.right = insert!(node_parent.right, value)
    end

    node_parent
  end


  def self.find!(tree_node, value)
    return nil if tree_node.nil?

    return tree_node if tree_node.value == value
    if tree_node.value < value
      self.find!(tree_node.right, value)
    else
      self.find!(tree_node.left, value)
    end
  end


  # helper method for #delete:
  def self.maximum(tree_node = @root)
    return nil if tree_node.nil?

    if tree_node.right
      return self.maximum(tree_node.right)
    end

    tree_node
  end

  def maximum(tree_node = @root)
    return nil if tree_node.nil?

    if tree_node.right
      return maximum(tree_node.right)
    end

    tree_node
  end

  def depth(node = @root)
    return -1 unless node
    left = 1 + depth(node.left)
    right = 1 + depth(node.right)
    left > right ? left : right
  end

  def is_balanced?(tree_node = @root)
    #will make sure that depth of left and right subtrees is at most 1
    #that both left and right right are balanced subtrees
    return true if tree_node.nil?

    left_tree = self.depth(tree_node.left)
    right_tree = self.depth(tree_node.right)
    ((left_tree - right_tree).abs < 2) && is_balanced?(tree_node.left)&& is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    #find the left tree's values first, then record middle,
    #then right tree
    return [] unless tree_node
    arr += in_order_traversal(tree_node.right, arr)
      arr <<  tree_node.value
      arr = in_order_traversal(tree_node.left, arr)
    arr
  end

  def in_order_traversal_iteratively(tree_node)
    stack = []
    current = tree_node

    until current.nil? && stack.empty?
      if current
        stack << current
        current = current.left
      else
        top_node = stack.pop
        p top_node.value
        current = top_node.right
      end
    end
  end

  # while !tree_node.left.nil?
  #   tree_node = tree_node.left
  #   ordered << tree_node
  # end
  #
  # p ordered.pop.value
  # p ordered.last.value
  #
  # tree_node
  # while !ordered.last.right.nil?
  #
  #   while !ordered.last.right.left.nil? || !ordered.last.right.right.nil?
  #     tree_node = tree_node.left
  #     ordered << tree_node
  #   end

  private
  # optional helper methods go here:

  def self.promote_child(tree_node)
    if tree_node.right
      current_parent = tree_node
      maximum_node = self.maximum(tree_node.right)
    else
      return tree_node
    end
    current_parent.right = maximum_node.left
  end

  def self.delete!(node, value)
    return nil unless node

    # one child -> return that child
    if node.value == value
      #check if children
      if node.left.nil? && node.right.nil?
        #no children
        node = nil
        return node
      elsif node.left && !node.right
        #one left child
        replacement = self.maximum(node.left)
        replacement.right = self.maximum(replacement.left)
        replacement.left = node.left
        return replacement
      elsif node.right && !node.left
        #one right child
        replacement = node.right
        return replacement
      else
        #two children
        replacement = self.maximum(node.left)
        # replace node value for left and right
        if replacement.left
          self.promote_child(node.left)
        end
        replacement.left = node.left
        replacement.right = node.right
        return replacement
      end

    elsif value < node.value
      node.left = delete!(node.left, value)
    else
      node.right = delete!(node.right, value)
    end

    node
  end

  def remove_from_tree(tree_node, value)
    if value == tree_node.value
      remove(tree_node)
    elsif value < tree_node.value
      tree_node.left = remove_from_tree(tree_node.left,value)
    else
      tree_node.right = remove_from_tree(tree_node.right,value)
    end

    tree_node
  end

  def remove(node)
    if node.right.nil? && node.left.nil?
      ndoe=nil
    elsif node.left && node.right.nil?
      node = node.left
    elsif node.left.nil? && node.right
      node = node.right
    else
      node = replace_parent(node)
    end
  end

  def replace_parent(node)
    replacement_node = maximum(node.left)

    if replacement_node.left
      node.left.right = replacement_node.left
    end

    replacement_node.left = node.left
    replacement_node.right = node.right
  end

end
