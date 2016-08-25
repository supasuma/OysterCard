class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journey_history = []
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    record_journey
    reset_journey
  end

  private

  attr_reader :current_journey, :journey_history

  def record_journey
    journey_history << current_journey
  end

  def reset_journey
    @current_journey = nil
  end

end
