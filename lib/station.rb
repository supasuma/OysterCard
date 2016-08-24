class Station
 attr_reader :station, :zone

  def initialize(station: station, zone: zone)
    @station = station
    @zone = zone
  end

end
