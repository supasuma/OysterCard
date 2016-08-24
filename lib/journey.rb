# station of entry
# station of exit

# fare - how much journey costs

class Journey

  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

end
