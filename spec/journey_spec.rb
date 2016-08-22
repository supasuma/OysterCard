require 'journey'

describe Journey do

subject(:journey) { described_class.new 'Bank'}
subject(:journey2) { described_class.new }

  describe '#initialize' do
    it 'should initialize with entry_station' do
      expect(journey.entry_station).to eq 'Bank'
    end

    it 'should initialize with an "unknown station" if no argument given' do
      expect(journey2.entry_station).to eq 'Unknown station'
    end
  end

  describe '#complete' do

    it 'should return the exit_station after completing a journey' do
      journey.complete('Temple')
      expect(journey.exit_station).to eq 'Temple'
    end

  end

  describe '#fare' do
    it 'successfully completes journey and sets fare' do
      journey.complete('Temple')
      expect(journey.fare).to eq 1.00
    end
  end 
end
