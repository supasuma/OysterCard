class Oystercard

  attr_reader :balance

   def initialize
     @balance = 0.00
   end

   def top_up(amount)
     @balance += amount
   end

end
