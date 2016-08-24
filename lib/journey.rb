require_relative 'oystercard'
# => Knows everything about a journey
class Journey

  def initialize
    @in_journey = false
    @start_station = nil
  end

  def in_journey?
    in_journey
  end

  def start(station)
    self.in_journey = true
    @start_station = station
  end

  def finish
    self.in_journey = false
  end


private

  attr_accessor :in_journey

end
