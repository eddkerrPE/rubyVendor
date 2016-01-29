require_relative '../src/machine'
require_relative '../src/snack'

describe "Machine" do

  it "must vend a snack" do
    machine = Machine.new()
    snack = Snack.new('Chips', 1)
    expect(machine.vend(snack)).to eq(snack)
  end

  it "must be able to total currencies in a given payment" do
    quarter = Currency.new('Quarter', 0.25)
    machine = Machine.new()
    payment = [quarter, quarter]
    expect(machine.countChange(payment)).to eq(0.50)
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

