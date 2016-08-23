require 'journey'

class Oystercard

  attr_reader :balance, :limit, :fare, :entry_station, :journeys

  DEFAULT_LIMIT = 90
  DEFAULT_BALANCE = 0

  def initialize(limit = DEFAULT_LIMIT, balance = DEFAULT_BALANCE)
    @limit = limit
    @balance = balance
    @journey = nil
    @journeys = []
    fail 'Balance cannot be larger than limit' if balance > limit
  end

  def top_up(amount)
    fail 'Balance limit reached' if full? || amount > limit
    @balance += amount
    balance_confirmation
  end

  def touch_in(station)
    fail 'Insufficient funds' if balance < Journey::MINIMUM_FARE
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.complete(station)
    deduct(@journey.fare)
    record_journey
    @entry_station = nil
  end

  #def in_journey?
  #  @entry_station != nil
  #end

  private

  def full?
    balance >= limit
  end

  def balance_confirmation
    "Your new balance is #{balance}"
  end

  def deduct(amount)
    fail 'Insufficient funds' if amount > balance
    @balance -= amount
    balance_confirmation
  end

  def record_journey
    @journeys << @journey.receipt
  end

end
