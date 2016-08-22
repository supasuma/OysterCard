class Oystercard

  attr_reader :balance

  BALANCE_LIMIT = 90.00

   def initialize
     @balance = 0.00
     @in_journey = false
   end

   def top_up(amount)
     fail "Top up would exceed limit £#{BALANCE_LIMIT}" if amount + balance > BALANCE_LIMIT
     @balance += amount
   end

   def deduct(amount)
     @balance -= amount
   end

   def in_journey?
     @in_journey
   end

   def touch_in
     @in_journey = true
   end

   def touch_out
     @in_journey = false
   end



end
