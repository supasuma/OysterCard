class Oystercard

  attr_reader :balance, :entry_station, :view_history

  BALANCE_LIMIT = 90.00
  MINIMUM_BALANCE = 1.00

   def initialize
     @balance = 0.00
     @entry_station = nil
     @view_history = []
   end

   def top_up(amount)
     fail "Top up would exceed limit £#{BALANCE_LIMIT}" if amount + balance > BALANCE_LIMIT
     @balance += amount
   end

   def in_journey?
     !@entry_station.nil?
   end

   def touch_in(entry_station)
     fail "Insufficient Funds Available. Minimum Balance £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
     update_entry_station(entry_station)
   end

   def touch_out(exit_station)
     deduct(1.00)
     add_to_history(entry_station, exit_station)
     forget_entry_station
   end

   private

   def deduct(fare)
     @balance -= fare
   end

   def update_entry_station(entry_station)
     @entry_station = entry_station
   end

   def forget_entry_station
     @entry_station = nil
   end

   def add_to_history(entry, exit)
     @view_history << {entry => exit}
   end
end
