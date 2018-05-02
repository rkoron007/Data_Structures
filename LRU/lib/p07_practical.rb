require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new

  string.chars.each_with_index do |char, i|
    hash[char] += 1
  end

  not_palindrome = hash.select{|k,v| v > 3}
  if not_palindrome
    return false
  else
    true
  end
end
