class Oystercard

attr_reader :balance, :in_journey

LIMIT = 90
BALANCE = 0
  def initialize(balance = BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'not enough credit' if empty?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def full?(amount)
    @balance + amount > LIMIT
  end

  def empty?
    @balance < 1
  end

end
