require_relative 'journey_log'
require_relative 'Journey'
require_relative 'Station.rb'

class Oystercard
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  MAXIMUM_LIMIT = 90

  attr_reader :balance

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def touch_in(station_name)
    fail "Insufficient funds. Please top up." if @balance < MINIMUM_FARE + PENALTY_FARE
    no_touch_out if @journey_log.in_journey?
    start_journey(station_name)
  end


  def touch_out(station)
    no_touch_in(station) if !@journey_log.in_journey?
    @journey_log.finish(station)
    deduct(@journey_log.get_last_fare)
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + @balance > MAXIMUM_LIMIT
    @balance += amount
  end

  private

  def no_touch_in(station)
    @journey_log.start(nil)
    deduct(PENALTY_FARE)
  end

  def no_touch_out
    deduct(PENALTY_FARE)
    @journey_log.finish(nil)
  end

  def start_journey(station)
    @journey_log.start(station)
  end

  def deduct(amount)
    @balance -= amount
  end

end
