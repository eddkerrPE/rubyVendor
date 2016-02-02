class Machine
  attr_reader :itemsInStock

  def initialize(itemsInStock, machineCurrency)
    @itemsInStock = itemsInStock
    @machineCurrency = machineCurrency
  end

  def vend(itemRequested)
    if itemRequested == nil
      return 'Out of Stock'
    end
    return @itemsInStock.delete(itemRequested)
  end

  def countChange(payment)
    changeDue = 0
    payment.each {|currency| changeDue += currency.value}
    return changeDue
  end

  def checkInventory(item)
    return @itemsInStock.include? item
  end

  def findHighestNote(currencySet, changeDue)
    filteredCurrency = currencySet.keep_if {|currency| currency.value <= changeDue}
    sortedAndFilteredCurrency = filteredCurrency.sort { |a,b| b.value <=> a.value}
    return sortedAndFilteredCurrency.first
  end

  def returnChange(currencySet, changeDue)
    change = []
    while changeDue > 0
      nextCoin = findHighestNote(currencySet, changeDue)
      change.push(nextCoin)
      changeDue -= nextCoin.value
    end
    return change
  end

  def transaction(itemRequested, payment)
    if !checkInventory(itemRequested)
      return "Out Of Stock!"
    end
    changeDue = countChange(payment) - itemRequested.cost
    change = returnChange(@machineCurrency, changeDue)
    item = vend(itemRequested)
    itemAndChange = [item, change]
    return itemAndChange
  end

end



