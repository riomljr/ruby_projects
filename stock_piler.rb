days_prices = [17,3,6,9,15,8,6,1,10]

def stock_picker(prices)
  len = prices.length
  min = prices.min(len/2)
  days = Hash.new(0)
  indexes = []
  profit=[]
 
  prices.each_with_index do |value, i|
    prices.each_with_index do|val, x| 
      profit.push((val-value)) if (val - value) > 0 && (x>=i)
    end
  end

  prices.each_with_index do |value, i|
    prices.each_with_index do|val, x| 
      print "buy day #{i} and sell day #{x} " if (val - value) == profit.max
    end
  end


end

stock_picker(days_prices)