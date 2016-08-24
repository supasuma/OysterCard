require_relative 'oystercard'

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

private
attr_accessor :in_journey



end
