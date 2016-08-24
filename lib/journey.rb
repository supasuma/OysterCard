require_relative 'oystercard'
# => Knows everything about a journey
class Journey

  def initialize
    @in_journey = false
  end

  def in_journey?
    in_journey
  end

  def start
    self.in_journey = true
  end

  def finish
    self.in_journey = false
  end


private

  attr_accessor :in_journey

end
