require_relative 'heap'

def k_largest_elements(array, k)
  #have an array
  #given k find the k largest elements in array
  # last_k = array.sort.drop(array.length - k)


  result = BinaryMinHeap.new

  #number of element times push in the last elements of array
  #this ensures extra elements
  k.times do |i|
    result.push(array.pop)
  end

  #then push in all the other elements
  while array.length > 0
    result.push(array.pop)
    result.extract
  end

  result.store
end
