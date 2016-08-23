require_relative 'oyster'

class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1.0
  PENALTY_FARE = 6.0

  def initialize(entry_station = "Hammersmith")
    @entry_station = entry_station
    @exit_station = ""
  end



  def finish(exit_station)
    current_journey = {:entry => @entry_station, :exit => exit_station}
    #current_journey[:exit] << exit_station
  end

  def complete?
    if @entry_station == nil
    end
  end

  def fare
    PENALTY_FARE if !complete?
    MINIMUM_FARE
  end

end
