class Oystercard

  attr_reader :balance

  BALANCE_LIMIT = 90.00
  MINIMUM_BALANCE = 1.00

   def initialize
     @balance = 0.00
     @in_journey = false
   end

   def top_up(amount)
     fail "Top up would exceed limit £#{BALANCE_LIMIT}" if amount + balance > BALANCE_LIMIT
     @balance += amount
   end

   def in_journey?
     @in_journey
   end

   def touch_in
     fail "Insufficient Funds Available. Minimum Balance £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
     @in_journey = true
   end

   def touch_out
     @in_journey = false
     deduct(1.00)
   end

   private

      def deduct(fare)
        @balance -= fare
      end

end
