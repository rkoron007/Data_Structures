class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    prc ||= Proc.new {|x, y| x <=> y}
    pivot = array.first
    array = array.drop(1)
    left = array.select{ |el| prc.call(pivot, el) > 0}
    right = array.select{ |el| prc.call(pivot, el) <= 0}

    sorted_left = QuickSort.sort1(left)
    sorted_right = QuickSort.sort1(right)

    sorted_left + [pivot] + sorted_right
  end


  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new {|x, y| x <=> y}

    #find our current pivot
    new_pivot_index = partition(array, start, length, &prc)

    #once we found that pivot we call
    #sort on the left and right halves of the array
    left_length = new_pivot_index - start
    right_length = length - (left_length + 1)

    sort2!(array, start, left_length, &prc)
    sort2!(array, new_pivot_index + 1, right_length, &prc)
    return array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    #given an array and a place to start I iterate through and move
    #partition over if the element I find is less than pivot.

    #pick random pivot
    random_num = start + rand(length)

    array[random_num], array[start] = array[random_num], array[start]
    #swapped array and pivot in place
    pivot = array[start]
    pivot_index = start

    # our pivot is at the start so we
    # just ned to go till the end of our window
   ((start + 1)...(start + length)).each do |idx|
      next unless prc.call(pivot, array[idx]) > 0

      #move our partition
      pivot_index += 1
      array[pivot_index], array[idx] = array[idx], array[pivot_index]
    end

    array[start], array[pivot_index] = array[pivot_index], array[start]
    pivot_index
  end


  def kth_small_stuff(k)
    #write in an in place instance method
    left = 0
    right = self - 1

    loop do
      return self[left] if left == right
      pivot_idx = Array.partition(self, left, right - left + 1)
      right - 1

      if k - 1 == pivot_idx
        return self[k-1]
      elsif k - 1 < pivot_idx
        right = pivot_idx - 1
      else
        left = pivot_idx + 1
      end
    end
  end

end
