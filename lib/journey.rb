require_relative 'oystercard'
# => Knows everything about a journey
class Journey

  def initialize
    @in_journey = false
    @start_station = nil
    @end_station = nil
    @journeys = []
  end

  def in_journey?
    in_journey
  end

  def start(station)
    self.in_journey = true
    @start_station = station
    @journeys << {in: station}
  end

  def finish(station)
    self.in_journey = false
    @end_station = station
    @journeys[-1][:out] = station
  end


private

  attr_accessor :in_journey

end
