require_relative '../src/machine'
require_relative '../src/snack'

describe "Machine" do
  emptyStock = []

  ### some snacks
  chips = Snack.new('Chips', 1.00)
  snickers = Snack.new('Snickers', 0.75)
  caviar = Snack.new('Caviar', 500)
  gum = Snack.new('Gum', 0.37)

  ## some currency
  quarter = Currency.new('Quarter', 0.25)
  dime = Currency.new('Dime', 0.10)
  nickel = Currency.new('Nickel', 0.05)
  penny = Currency.new('Penny', 0.01)

  americanCoins = [quarter, dime, nickel, penny]

  it "must vend a snack" do
    machine = Machine.new([chips])
    expect(machine.vend(chips)).to eq(chips)
  end

  it "must be able to total the value of the currency in a given payment" do
    machine = Machine.new(emptyStock)
    payment = [quarter, quarter]
    expect(machine.countChange(payment)).to eq(0.50)
  end

  it "must be able to find the highest note of a given currency set that is smaller than the payment due" do
    machine = Machine.new(emptyStock)
    newCurrencySet = [quarter, dime, nickel, penny]
    expect(machine.findHighestNote(newCurrencySet, 0.26)).to eq(quarter)
    expect(machine.findHighestNote(newCurrencySet, 0.25)).to eq(quarter)
    expect(machine.findHighestNote(newCurrencySet, 0.24)).to eq(dime)

  end



  it "count and inventory the amount of each item it has" do
    itemsInStock = [chips, chips, chips, snickers]
    machine = Machine.new(itemsInStock)
    expect(machine.checkInventory(chips)).to be true
    expect(machine.checkInventory(caviar)).to be false
  end

  it "must remove an item from its inventory after vending it" do
    itemsInStock = [chips, chips, gum, snickers]
    machine = Machine.new(itemsInStock)
    expect(machine.itemsInStock.length).to eq(4)
    machine.vend(gum)
    expect(machine.itemsInStock.length).to eq(3)
  end

end

describe "Snack" do
  it "must have a name and cost" do
    chips = Snack.new('Chips', 1)
    expect(chips.name).to eq('Chips')
    expect(chips.cost).to eq(1)
  end
end

describe "Currency" do
  it "must have a type and a value" do
    quarter = Currency.new('Quarter', 0.25)
    expect(quarter.type).to eq('Quarter')
    expect(quarter.value).to eq(0.25)
  end
end


