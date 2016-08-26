#knows how to store journeys
class JourneyLog

  PENALTY_FARE = 6

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @history = []
    @outstanding_charges = 0
  end

  def start(station)
    no_touch_out unless current_journey.nil?
    @current_journey = @journey_class.new
    current_journey.start(station)
  end

  def finish(station)
    no_touch_in if current_journey.nil?
    current_journey.finish(station)
    get_charges
    record_journey
    reset_current_journey
  end

  def get_outstanding_charges
    hold = outstanding_charges
    @outstanding_charges = 0
    hold
  end

  private

  attr_reader :current_journey, :outstanding_charges

  def no_touch_in
    @current_journey = @journey_class.new
    current_journey.start(nil)
    @outstanding_charges += PENALTY_FARE
  end

  def no_touch_out
    current_journey.finish(nil)
    @outstanding_charges += PENALTY_FARE
    get_charges
    record_journey
    reset_current_journey
  end

  def record_journey
    @history << current_journey
  end

  def reset_current_journey
    @current_journey = nil
  end

  def get_charges
    @outstanding_charges += current_journey.fare
  end

end
