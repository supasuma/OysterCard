class Oystercard

LIMIT = 90
BALANCE = 0
MINIMUM_BALANCE = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    @entry_station = station
    fail 'below minimum balance' if empty?
    @in_journey = true
  end

  def touch_out(amount)
    deduct(amount)
    @in_journey = false
  end

  private

  attr_reader :balance, :in_journey, :entry_station

  def deduct(amount)
    @balance -= amount
  end

  def full?(amount)
    @balance + amount > LIMIT
  end

  def empty?
    @balance < MINIMUM_BALANCE
  end

end
