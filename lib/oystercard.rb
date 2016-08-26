require_relative 'station'
require_relative 'journey'

class Oystercard

LIMIT = 90
BALANCE = 0
MINIMUM_BALANCE = 1
PENALTY_FARE = 6

  def initialize(journey_log: JourneyLog.new)
    @balance = BALANCE
    @journey_log = journey_log
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    check_balance
    start_journey(station)
  end

  def touch_out(station)
    finish_journey(station)
  end

  private

  attr_reader :balance, :journey_log

  def check_balance
    fail 'below minimum balance' if empty?
  end

  def deduct(amount)
    @balance -= amount
  end

  def full?(amount)
    balance + amount > LIMIT
  end

  def empty?
    balance < MINIMUM_BALANCE
  end

  def start_journey(station)
    journey_log.start(station)
  end

  def finish_journey(station)
    journey_log.finish(station)
    deduct(journey_log.get_outstanding_charges)
  end

end
