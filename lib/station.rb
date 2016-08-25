class Station
 attr_reader :station, :zone

  def initialize(station: a_station, zone: a_zone)
    @station = station
    @zone = zone
  end

end
