require_relative 'oyster'

class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1.0

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = ""
  end

  def finish(exit_station)
    {:entry => @entry_station, :exit => exit_station}
  end

  def fare
    MINIMUM_FARE
  end

end
