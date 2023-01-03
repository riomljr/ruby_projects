def bubble_sort(numbers)
  len =numbers.length

  until numbers.sort == numbers do
    for index in 0...len -1
      if numbers[index] > numbers[index + 1]
        move = numbers[index]
        numbers[index] = numbers[index + 1]
        numbers[index + 1] = move
      end
    end
  end
  numbers
end

bubble = [4,3,78,2,0,2]

print bubble_sort(bubble)