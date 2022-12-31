def ceaser_cipher(string, amount)
  alpha_min_values = *('a'..'z')
  alpha_cap_values = *('A'..'Z')
  alpha = alpha_cap_values + alpha_min_values
  convert = []
  capital=[]
  encrypted =[]
  i = 0
 #converting to number
  string.each_char do |char|
    if alpha.include?(char)
      convert.push((alpha.find_index(char)))
      capital.push(i) if char == char.upcase #get cap letter indexes
    else
      convert.push(char) #ignore non-num values and add them
    end
    i += 1
  end
#converting num val to new char
  convert.each do |number|
    if number.is_a? Numeric
      num = number + amount 
      num = num -52 if num > 52
      encrypted.push(alpha[num])
    else
      encrypted.push(number)
    end
  end
#adjusting for upper and lower case in orignal string
  encrypted.each {|en| en.downcase!}
  capital.each {|value| encrypted[value].upcase!}
 
   print encrypted.join("")
end

 ceaser_cipher("Hi How Are You?", 10)

 ceaser_cipher("how are?", 5)


