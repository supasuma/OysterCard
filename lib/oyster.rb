require_relative 'station'
require_relative 'journey'

class Oyster
  attr_reader :balance, :journeys

  STARTING_BALANCE = 0.0
  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0
  PENALTY_FARE = 6.0

  def initialize(balance = STARTING_BALANCE, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  def touch_in(entry_station)
    fail "Not enough money on card." if @balance < MINIMUM_FARE
    no_touch_out if @journey_log.in_journey?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    no_touch_in(exit_station) unless @journey_log.in_journey?
    @journey_log.finish(exit_station)
    deduct(@journey_log.current_journey.fare)
    @journey_log.reset
  end

  def top_up(amount)
    fail "Oyster max balance is #{MAX_BALANCE}." if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  private

  def no_touch_in(exit_station)
    @journey_log.start(nil)
    deduct(PENALTY_FARE)
  end

  def no_touch_out
    @journey_log.finish(nil)
    deduct(PENALTY_FARE)
  end

  def deduct(amount)
    @balance -= amount
  end
end
