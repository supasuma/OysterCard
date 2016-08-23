require_relative 'oyster'

class Journey

  attr_reader :journeys

  def initialize(entry_station)
    @entry_station = entry_station
    @journeys = []
  end

  def exit

  end

end
