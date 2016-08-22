class Journey
  BASE_FARE = 1.00
  PENALTY_FARE = 6.00

  attr_reader :fare

  def initialize(entry_station = 'Unknown station')
    @entry_station = entry_station
    @exit_station = nil
    @fare = BASE_FARE
  end

  def complete(exit_station)
    @exit_station = exit_station
  end

  def penalty_fare
    @fare += PENALTY_FARE
  end

end
