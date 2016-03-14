require_relative '../src/machine'
require_relative '../src/snack'

describe "Machine" do
  emptyStock = []

  ### some snacks
  chips = Snack.new('Chips', 100)
  snickers = Snack.new('Snickers', 75)
  caviar = Snack.new('Caviar', 5000)
  gum = Snack.new('Gum', 37)

  ## some currency
  quarter = Currency.new('Quarter', 25)
  dime = Currency.new('Dime', 10)
  nickel = Currency.new('Nickel', 5)
  penny = Currency.new('Penny', 1)

  ## some japanese currency
  oneYenCoin = Currency.new('One Yen Coin', 1)
  fiveYenCoin = Currency.new('Five Yen Coin', 5)
  tenYenCoin = Currency.new('Ten Yen Coin', 10)
  hundredYenCoin = Currency.new('One Hundred Yen Coin', 100)
  fiveHundredYenCoin = Currency.new('Five Hundred Yen Coin', 500)
  thousandYenNote = Currency.new('Thousand Yen Coin', 1000)

  americanCoins = [quarter, dime, nickel, penny]
  japaneseCurrency = [oneYenCoin, fiveYenCoin, tenYenCoin, hundredYenCoin, fiveHundredYenCoin, thousandYenNote]

  it "must vend a snack" do
    machine = Machine.new([chips], americanCoins)
    expect(machine.vend(chips)).to eq(chips)
  end

  it "must be able to total the value of the currency in a given payment" do
    machine = Machine.new(emptyStock, americanCoins)
    payment = [quarter, quarter]
    expect(machine.countChange(payment)).to eq(50)
  end

  describe "#findHighestNote" do
    it "must return quarter for 26" do
      newCurrencySet = [quarter, dime, nickel, penny]
      machine = Machine.new(emptyStock, newCurrencySet)
      expect(machine.findHighestNote(newCurrencySet, 26)).to eq(quarter)
    end

    it "must return quarter for 25" do
      newCurrencySet = [quarter, dime, nickel, penny]
      machine = Machine.new(emptyStock, newCurrencySet)
      expect(machine.findHighestNote(newCurrencySet, 26)).to eq(quarter)
    end

    it "must return dime for 24" do
      newCurrencySet = [quarter, dime, nickel, penny]
      machine = Machine.new(emptyStock, newCurrencySet)
      expect(machine.findHighestNote(newCurrencySet, 24)).to eq(dime)
    end

  end


  it "must be able to return the smallest amount of notes for a given currency set and amount due" do
    currencySet = [quarter, dime, nickel, penny]
    machine = Machine.new(emptyStock, currencySet)
    # expect(machine.returnChange(currencySet, 41)).to eq([quarter, dime, nickel, penny])
    # expect(machine.returnChange(currencySet, 20)).to eq([dime, dime])
    expect(machine.returnChange(currencySet, 26)).to eq([quarter, penny])
  end

  it "must be able to accept Yen" do
    currencySet = japaneseCurrency
    payment = [tenYenCoin, tenYenCoin, tenYenCoin, tenYenCoin, tenYenCoin]
    machine = Machine.new(emptyStock, currencySet)
    expect(machine.countChange(payment)).to eq(50)
  end

  it "count and inventory the amount of each item it has" do
    itemsInStock = [chips, chips, chips, snickers]
    machine = Machine.new(itemsInStock, americanCoins)
    expect(machine.checkInventory(chips)).to be true
    expect(machine.checkInventory(caviar)).to be false
  end

  it "must remove an item from its inventory after vending it" do
    itemsInStock = [chips, chips, gum, snickers]
    machine = Machine.new(itemsInStock, americanCoins)
    expect(machine.itemsInStock.length).to eq(4)
    machine.vend(gum)
    expect(machine.itemsInStock.length).to eq(3)
  end

  it "must be able to perform a transaction, returning requested item and the correct change for the payment" do
    reeses = Snack.new('reeses', 76)
    itemsInStock = [reeses, chips, chips, gum, snickers]
    machine = Machine.new(itemsInStock, americanCoins)
    payment = [quarter, quarter, quarter, quarter]
    results = machine.transaction(reeses, payment)
    expect(results[1]).to eq([dime, dime, penny, penny, penny, penny])
    expect(results[0]).to eq(reeses)
  end

  it "must be able to perform a complete transaction in yen" do
    liveCrab = Snack.new('A Live Crab', 465)
    payment = [hundredYenCoin, hundredYenCoin, hundredYenCoin, hundredYenCoin, hundredYenCoin]
    panties = Snack.new('Panties', 10000)
    japaneseInventory = [liveCrab, panties]
    machine = Machine.new(japaneseInventory, japaneseCurrency)
    results = machine.transaction(liveCrab, payment)
    expect(results[1]).to eq([tenYenCoin,tenYenCoin,tenYenCoin,fiveYenCoin])
    expect(results[0]).to eq(liveCrab)
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
    quarter = Currency.new('Quarter', 25)
    expect(quarter.type).to eq('Quarter')
    expect(quarter.value).to eq(25)
  end
end


