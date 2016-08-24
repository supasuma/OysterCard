# station of entry
# station of exit

# fare - how much journey costs

class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare = nil
  end

  def fare_is(fare)
    @fare = fare
  end

  def exit_station_is(exit_station)
    @exit_station = exit_station
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end
end
