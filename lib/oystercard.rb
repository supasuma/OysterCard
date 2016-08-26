require_relative 'station'
require_relative 'journey'

class Oystercard

LIMIT = 90
BALANCE = 0
MINIMUM_BALANCE = 1
PENALTY_FARE = 6

  def initialize(balance: BALANCE, journey: Journey)
    @balance = balance
    @journey_class = journey
    @current_journey = nil
    @history = []
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    check_balance
    no_touch_out unless current_journey == nil
    start_journey(station)
  end

  def touch_out(station)
    no_touch_in if current_journey == nil
    finish_journey(station)
  end

  private

  attr_reader :balance, :current_journey, :journey_class

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

  def no_touch_out
    current_journey.finish(nil)
    deduct(PENALTY_FARE)
    record_journey
    @current_journey = nil
  end

  def no_touch_in
    @current_journey = journey_class.new
    current_journey.start(nil)
    deduct(PENALTY_FARE)
  end

  def record_journey
    @history << current_journey
  end

  def start_journey(station)
    @current_journey = journey_class.new
    current_journey.start(station)
  end

  def finish_journey(station)
    current_journey.finish(station)
    deduct(current_journey.fare)
    record_journey
    @current_journey = nil
  end

end
