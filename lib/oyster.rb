

class Oyster
  attr_reader :balance, :in_journey
  alias in_journey? in_journey

  STARTING_BALANCE = 0.0
  MAX_BALANCE = 90.0

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def top_up(amount)
    fail "Oyster max balance is #{MAX_BALANCE}." if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
