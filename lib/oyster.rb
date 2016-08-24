require_relative 'station'
require_relative 'journey'

class Oyster
  attr_reader :balance, :journeys

  STARTING_BALANCE = 0.0
  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0
  PENALTY_FARE = 6.0

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @in_journey = false
    @journeys = []
  end

  def in_journey?
    if @current_journey  == nil
      @in_journey = false
    else
      @in_journey = true
    end
  end

  def touch_in(entry_station)
    fail "Not enough money on card." if @balance < MINIMUM_FARE
    no_touch_out if @current_journey != nil
    @current_journey = Journey.new(entry_station)
    in_journey?
  end

  def touch_out(exit_station)
    no_touch_in(exit_station) if @current_journey.nil?
    deduct(@current_journey.fare)
    record_journey(@current_journey.finish(exit_station))
    @current_journey  = nil
    in_journey?
  end

  def top_up(amount)
    fail "Oyster max balance is #{MAX_BALANCE}." if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  private

  def no_touch_in(exit_station)
    @current_journey = Journey.new(nil)
    deduct(PENALTY_FARE)
  end

  def no_touch_out 
    record_journey(@current_journey.finish(nil))
    deduct(PENALTY_FARE)
    @current_journey  = nil
  end

  def record_journey(current_journey)
    @journeys << current_journey
  end

  def deduct(amount)
    @balance -= amount
  end
end
