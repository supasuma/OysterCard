require_relative 'journey'
class Oystercard

  attr_reader :balance, :journey, :view_history

  BALANCE_LIMIT = 90.00
  MINIMUM_BALANCE = 1.00

   def initialize
     @balance = 0.00
     @journey = nil
     @view_history = []
   end

   def top_up(amount)
     fail "Top up would exceed limit £#{BALANCE_LIMIT}" if amount + balance > BALANCE_LIMIT
     @balance += amount
   end

   def touch_in(entry_station, journey_class = nil)
     fail "Insufficient Funds Available. Minimum Balance £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
     create_new_journey(entry_station, journey_class)
   end

   def touch_out(exit_station, journey_class = nil)
    complete_journey(exit_station, journey_class)
    add_to_history(journey.entry_station, journey.exit_station)
    @journey = nil
   end

   private

   def deduct(fare)
     @balance -= fare
   end

   def create_new_journey(entry_station, journey_class = Journey.new(entry_station))
     @journey.nil? ? @journey = journey_class : create_new_penalty_journey(entry_station, journey_class)
   end

   def create_new_penalty_journey(entry_station, journey_class = Journey.new(entry_station))
     complete_journey("Unknown Station")
     charge_penalty_to_account
     add_to_history(journey.entry_station, journey.exit_station)
     @journey = journey_class
   end

   def charge_penalty_to_account
     @journey.penalty_fare
     deduct(@journey.fare)
   end

   def complete_journey(exit_station, journey_class = Journey.new)
     if @journey.nil?
       @journey = journey_class
       @journey.penalty_fare
     end
       @journey.complete(exit_station)
       deduct(@journey.fare)
   end

   def add_to_history(entry, exit)
     @view_history << {entry => exit}
   end
end
