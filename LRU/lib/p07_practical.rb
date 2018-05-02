require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = Hash.new(0)

  string.chars.each do |char|
    hash[char] += 1
  end

  sum = 0
  hash.each do |k, v|
    if v.odd?
      sum += v
    end
  end

  if sum > 1
    return false
  else
    true
  end
end
