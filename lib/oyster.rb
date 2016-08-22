

class Oyster
  attr_reader :balance, :in_journey
  alias in_journey? in_journey

  STARTING_BALANCE = 0.0
  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def touch_in
    fail "Not enough money on card." if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    @balance -= MINIMUM_FARE
  end

  def top_up(amount)
    fail "Oyster max balance is #{MAX_BALANCE}." if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
