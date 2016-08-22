class Journey

  attr_reader :entry_station , :exit_station , :fare

  def initialize(entry_station = 'Unknown station')
    @entry_station = entry_station
    @exit_station = nil
    @fare = 1.00
  end

  def complete(exit_station)
    @exit_station = exit_station
  end

  def penalty_fare
    @fare += 6.00
  end

end
