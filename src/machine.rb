class Machine
  attr_reader :itemsInStock

  def initialize(itemsInStock)
    @itemsInStock = itemsInStock
  end

  def vend(itemRequested)
    for item in @itemsInStock
      if item == itemRequested
        @itemsInStock.delete(item)
        return itemRequested
        return
      end
    end
    return item
  end

  def countChange(payment)
    changeDue = 0
    for currency in payment
      changeDue += currency.value
    end
    return changeDue
  end

  def checkInventory(item)
    for stockedItem in @itemsInStock do
      if stockedItem == item
        return true
      end
      return false
    end
  end

  def findHighestNote(currencySet, changeDue)
    currencyChoices = currencySet.sort! { |a,b| b.value <=> a.value}
    for currency in currencyChoices
      if currency.value > changeDue
        currencyChoices.delete(currency)
      end
    end
    return currencyChoices[0]
  end

  def returnChange(currencySet, changeDue)
    change = []
    while changeDue > 0
      nextCoin = findHighestNote(currencySet, changeDue)
      changeDue -= nextCoin.value
      change.push(nextCoin)
    end
    return change
  end


end



