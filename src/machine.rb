

class Machine
  def initialize
    return
  end

  def vend(itemRequested)
    item = itemRequested
    return item
  end

  def countChange(payment)
    changeDue = 0
    for currency in payment
      changeDue += currency.value
    end
    return changeDue
  end

end



