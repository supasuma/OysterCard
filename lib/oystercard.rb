require_relative 'station'
require_relative 'journey'

class Oystercard

attr_accessor :journeys

LIMIT = 90
BALANCE = 0
MINIMUM_BALANCE = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail 'below minimum balance' if empty?
    @entry_station = station
    Journey.new.start(station)

  end

  def touch_out(station)
    @exit_station = station
#    deduct(amount)
  end

  private

  attr_reader :balance, :entry_station

  def deduct(amount)
    @balance -= amount
  end

  def full?(amount)
    @balance + amount > LIMIT
  end

  def empty?
    @balance < MINIMUM_BALANCE
  end

end
