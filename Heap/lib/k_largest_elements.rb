require_relative 'heap'

def k_largest_elements(array, k)
  #have an array
  #given k find the k largest elements in array
  last_k = array.sort.drop(array.length - k)
  
end
