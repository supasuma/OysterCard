require_relative 'oystercard'
# => Knows everything about a journey
class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :history

  def initialize
    @history = []
    @current_journey = {}
  end

  def complete?

    case
    when !!current_journey[:in] && !!current_journey[:out]
      true
    when !current_journey[:in] && !current_journey[:out]
      true
    when !!current_journey[:in] && !current_journey[:out]
      false
    when !current_journey[:in] && !!current_journey[:out]
      false
    end

  end

  def start(station)
    @current_journey[:in] = station
  end

  def finish(station)
    @current_journey[:out] = station
  end

  def completed_journeys
    @current_journey
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

private

attr_reader :current_journey

end
