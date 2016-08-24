require_relative 'oyster'

class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1.0

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station)
    @exit_station = exit_station
    {:entry => @entry_station, :exit => @exit_station}
  end

  def fare
    return MINIMUM_FARE if entry_station.nil? || exit_station.nil?
    MINIMUM_FARE + (@entry_station.zone - @exit_station.zone).abs
  end

  
end
