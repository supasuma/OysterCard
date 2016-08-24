class Oystercard

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance , :entry_station, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Please top up." if balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    if in_journey? == false #touched out but not touched in
      deduct(PENALTY_FARE)
      journeys << { entry_station: nil, exit_station: exit_station }
    elsif in_journey? == true #normal journey - touched in and out
      deduct(MINIMUM_FARE)
      journeys << { entry_station: entry_station, exit_station: exit_station}
    end
      @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
