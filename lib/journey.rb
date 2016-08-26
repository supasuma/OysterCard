# => Knows everything about a journey
class Journey

  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def return_zones
    [@entry_station.zone, @exit_station.zone]
  end

end
