

class Oyster
  attr_reader :balance
  STARTING_BALANCE = 0.0
  MAX_BALANCE = 90.0

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Oyster max balance is #{MAX_BALANCE}." if @balance + amount > MAX_BALANCE
    @balance += amount
  end


end
