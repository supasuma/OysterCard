class Journey

  attr_reader :fare

  MINIMUM_FARE = 1

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare = MINIMUM_FARE
  end

  def complete(exit_station)
    @exit_station = exit_station
  end

  def receipt
    {entry: @entry_station, exit: @exit_station}
  end

end
