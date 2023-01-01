def substrings(inputs, dict)
  new_word = inputs.gsub(/[[:punct:]]/, '').downcase.split(' ')
  count = Hash.new(0)

  new_word.each { |value| count[value] += 1 if dict.include?(value)}
  return print count
end

dictionary =["hello", "how", "you", "too", "if", "is", "ok"]
substrings("Hello! how how how is it going? are you ok?", dictionary)