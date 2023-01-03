def bubble_sort(numbers)
  len = (numbers.length)
  max_loops = len * len  
  loop_num = 0
  
  max_loops.times do
    if loop_num >=len 
      return numbers
    end
    for index in 0...len - 1
      if numbers[index] > numbers[index + 1]
        move = numbers[index]
        numbers[index] = numbers[index + 1]
        numbers[index + 1] = move
      else
        loop_num +=1
      end 
    end
  end

  numbers
end

bubble = [4,3,78,2,0,2]

print bubble_sort(bubble)

