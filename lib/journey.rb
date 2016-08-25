# station of entry
# station of exit

# fare - how much journey costs

class Journey
  MINIMUM_FARE = 1

attr_reader :fare

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare = MINIMUM_FARE
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end
end
