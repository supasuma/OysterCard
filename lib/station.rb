class Station
  attr_reader :name, :zone

  def initialize(name)
    @name = name
    @stations_zones = {:Aldgate => 1, :Ladbroke_Grove => 2}
    @zone = stations_zones[:name]
  end

end
