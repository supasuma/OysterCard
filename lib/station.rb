class Station
  attr_reader :name, :zone
  def initialize(name = 'Unknown', zone = :Unknown)
    @name = name.to_s
    @zone = zone.to_sym
  end
end
