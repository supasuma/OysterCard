require 'journey'

class JourneyLog
  attr_reader :journey_history
  def initialize (journey_class = Journey)
    @journey_class = journey_class
    @journey_history = []
    @current_journey = nil
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def finish(exit_station)
    @journey_history << @current_journey.finish(exit_station)
  end
end
