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

   def touch_in(entry_station)
     fail "Insufficient Funds Available. Minimum Balance £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    create_new_journey(entry_station)
   end

   def touch_out(exit_station)
    complete_journey(exit_station)
    add_to_history(journey.entry_station, journey.exit_station)
    deduct(@journey.fare)
    @journey = nil
   end

   private

   def deduct(fare)
     @balance -= fare
   end

   def create_new_journey(entry_station)
     if @journey.nil?
       @journey = Journey.new(entry_station)
     else
       @journey.penalty_fare
     end
   end

   def complete_journey(exit_station)
     if @journey.nil?
       @journey = Journey.new
       @journey.penalty_fare
     end
       @journey.complete(exit_station)
   end

   def add_to_history(entry, exit)
     @view_history << {entry => exit}
   end
end
