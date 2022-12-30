def ceaser_cipher(string, number)
  alpha_values = *('a'..'z')
  alpha_cap_values= *('A'..'Z')
  convert_to_num = []

  string.each_char do |char| 
    if alpha_values.include?(char)
      convert_to_num.push((alpha_values.find_index(char)) + number)
    end   
  end

  convert_to_num.each do |number|
    puts alpha_values[number]
  end

end

 ceaser_cipher("hello", 2)