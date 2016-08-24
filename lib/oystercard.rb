require_relative 'JourneyHistory.rb'
require_relative 'Journey'
require_relative 'Station.rb'

class Oystercard
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = JourneyHistory.new
  end



  def touch_in(station_name)
    fail "You don't have enough money on your card" if @balance < MINIMUM_FARE
    # station = Station.new(station_name)
      station = station_name #this is temp before we get the stations integrated

    if @in_journey == true
      @current_journey.exit_station_is(nil)
      deduct(PENALTY_FARE)
      @current_journey.fare_is(PENALTY_FARE)
      @journey_history.record_journey(@current_journey)
    end
    start_journey(station)
  end


  def touch_out(station)
    if @in_journey == true
      @current_journey.exit_station_is(station)
      @current_journey.fare_is(MINIMUM_FARE)
      deduct(MINIMUM_FARE)
    else #have not touched in but are now touching out
      @current_journey = Journey.new(nil) #sets entry station to nil
      @current_journey.exit_station_is(station)
      @current_journey.fare_is(PENALTY_FARE)
      deduct(PENALTY_FARE)
    end
    end_journey
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  private

  def end_journey
    @journey_history.record_journey(@current_journey)
    @in_journey = false
  end

  def start_journey(station)
    @current_journey = Journey.new(station)
    @in_journey = true
  end

  def deduct(amount)
    @balance -= amount
  end
end
