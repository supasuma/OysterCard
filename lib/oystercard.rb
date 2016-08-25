require_relative 'JourneyHistory.rb'
require_relative 'Journey'
require_relative 'Station.rb'

class Oystercard
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  MAXIMUM_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @current_journey = nil
    @journey_history = []
  end



  def touch_in(station_name)
    fail "Insufficient funds. Please top up." if @balance < MINIMUM_FARE

    if @current_journey
      deduct(PENALTY_FARE)
      record_journey(@current_journey)
      @current_journey = nil
    end
    start_journey(station_name)
  end


  def touch_out(station)
    if @current_journey
      @current_journey.finish(station)
      deduct(@current_journey.fare)
    else
      @current_journey = Journey.new(nil)
      @current_journey.finish(station)
      deduct(PENALTY_FARE + @current_journey.fare)
    end
    end_journey
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  private

  def end_journey
    record_journey(@current_journey)
    @current_journey = nil
  end

  def start_journey(station)
    @current_journey = Journey.new(station)
  end

  def deduct(amount)
    @balance -= amount
  end

  def record_journey(journey)
    @journey_history << journey
  end
end
