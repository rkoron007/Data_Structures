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

  def self.promote_child(tree_node)
    if tree_node.right
      current_parent = tree_node
      maximum_node = self.maximum(tree_node.right)
    else
      return tree_node
    end
    current_parent.right = maximum_node.left
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
      return self.maximum(tree_node.right)
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
    left_tree = self.depth(tree_node.left)
    right_tree = self.depth(tree_node.right)
    if left_tree > right_tree + 1
      return false
    elsif right_tree > left_tree + 1
      return false
    end
    true

  end

  def in_order_traversal(tree_node = @root, arr = [])
    #find the left tree's values first, then record middle,
    #then right tree
    return [] unless tree_node
      arr = in_order_traversal(tree_node.left, arr)
      arr <<  tree_node.value
      arr += in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:

end
