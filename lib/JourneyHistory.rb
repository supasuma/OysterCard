class JourneyHistory
  def initialize
    @past_journies = []
  end

  def record_journey(journey)
    @past_journies << journey
  end
end
