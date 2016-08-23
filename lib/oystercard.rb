class Oystercard

attr_accessor :journeys

LIMIT = 90
BALANCE = 0
MINIMUM_BALANCE = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    fail 'below minimum balance' if empty?
    @entry_station = station
    @journeys << {@entry_station => nil}
  end

  def touch_out(amount, station)
    @exit_station = station
    @journeys[-1][@entry_station] = station
    deduct(amount)
    @entry_station = nil
  end

  private

  attr_reader :balance, :entry_station

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
