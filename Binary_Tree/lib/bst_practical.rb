
def kth_largest(tree_node, k)
  kth_node = {count: 0, correct_node:nil}

  reverse_in_order(tree_node, kth_node, k)
end


def reverse_in_order(tree_node, kth_node, k)

  if tree_node && kth_node[:k] < k
    kth_node = reverse_in_order(tree_node.right, kth_node,k)

      if kth_node[:count] < k
        kth_node[:count] += 1
        kth_node[:correct_node] = tree_node
      end
    end
end
