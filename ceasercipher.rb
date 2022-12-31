def ceaser_cipher(string, amount)
  alpha_min_values = *('a'..'z')
  alpha_cap_values = *('A'..'Z')
  alpha = alpha_cap_values + alpha_min_values
 
  capital=[]
  encrypted =[]
  i = 0
 
  string.each_char do |char|
    if alpha.include?(char)
      convert += ((alpha.find_index(char)))
      capital.push(i)if char == char.upcase
    else
      convert.push(char)
    end
    i += 1
  end

  convert.each do |number|
    if number.is_a? Numeric
      num = number + amount 
      num = num -52 if num > 52
      encrypted.push(alpha[num])
    else
      encrypted.push(number)
    end
  end

  encrypted.each {|en| en.downcase!}
  capital.each {|value| encrypted[value].upcase!}
 
   print encrypted.join("")
end


 ceaser_cipher("Hi How Are You?", 10)


