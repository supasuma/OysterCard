class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare = MINIMUM_FARE
    @penalty_fare = 0
  end

  def complete(exit_station)
    @exit_station = exit_station
  end

  def receipt
    {entry: @entry_station, exit: @exit_station, fare: fare}
  end

  def add_penalty_fare
    @penalty_fare = PENALTY_FARE
  end

  def fare
    @fare + @penalty_fare
  end

end
