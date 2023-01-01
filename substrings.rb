def substrings (inputs, dict)
  #removes punctuation, downcases and turns into array
  new_word = inputs.gsub(/[[:punct:]]/, '').downcase.split(' ')
  match = new_word & dict #finds match between string and dictionary
  count = Hash.new(0)
  
  #compares new_word against match, adds word and count to hash if found
  new_word.each { |value| count[value] += 1 if match.include?(value)}
  return count
end

dictionary =["hello", "how", "you", "too", "if", "is", "ok"]
substrings("Hello! how how how is it going? are you ok?", dictionary)