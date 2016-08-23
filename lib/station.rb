class Station
  attr_reader :name, :zone

  def initialize(options)
    @zone = options[:zone]
    @name = options[:name]
  end
end
