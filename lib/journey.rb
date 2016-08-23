require_relative 'oyster'

class Journey

  attr_reader :journeys, :entry_station

  PENALTY_FARE = 6.0

  def initialize(entry_station = "Hammersmith")
    @entry_station = entry_station
    @journeys = []
  end

  def complete?
    if @entry_station == nil
    end
  end

  def fare
    PENALTY_FARE if !complete?
  end

  def finish
    self
  end

end
