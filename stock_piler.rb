def stock_picker(prices)
  profit=[]
  indexes = []
 
  prices.each_with_index do |value, i|
    prices.each_with_index do|val, x| 
      if (val - value) > 0 && (x>=i)
        indexes += [[i, x]]
        profit.push((val-value))
      end
    end
  end

  days = profit.find_index(profit.max)
 
  print indexes[days]
end

days_prices = [17,3,6,9,15,8,6,1,10]
stock_picker(days_prices) #=> [1, 4]
