require_relative '../src/machine'
require_relative '../src/currency'


class Snack
  attr_reader :name, :cost
  def initialize(name, cost)
    @name = name
    @cost = cost
  end
end