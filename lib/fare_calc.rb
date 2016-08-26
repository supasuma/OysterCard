class FareCalculator
PENALTY_FARE = 6
MINIMUM_FARE = 1

  def calculate_fare(zones)
    fare = 0
    fare += PENALTY_FARE if zones[0].nil?
    fare += PENALTY_FARE if zones[1].nil?
    begin
      custom = (zones[0] - zones[1]).abs
    rescue
      custom = 0
    end
    fare += MINIMUM_FARE + custom
  end
  
end
