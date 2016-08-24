require 'journey'

class JourneyLog
  attr_reader :journey_history, :current_journey
  def initialize (journey_class = Journey)
    @journey_class = journey_class
    @journey_history = []
    @current_journey = nil
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def in_journey?
    !@current_journey.nil?
  end

  def finish(exit_station)
    @journey_history << @current_journey.finish(exit_station)
  end

  def reset
    @current_journey = nil
  end
end
