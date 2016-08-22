require 'journey'

describe Journey do

subject(:journey) { described_class.new 'Bank'}
subject(:journey2) { described_class.new }

  describe '#initialize' do
    it 'should initialize with entry_station' do
      expect(journey.instance_variable_get(:@entry_station)).to eq 'Bank'
    end

    it 'should initialize with an "unknown station" if no argument given' do
      expect(journey2.instance_variable_get(:@entry_station)).to eq 'Unknown station'
    end
  end

  describe '#complete' do

    it 'should return the exit_station after completing a journey' do
      journey.complete('Temple')
      expect(journey.instance_variable_get(:@exit_station)).to eq 'Temple'
    end
  end

  describe '#fare' do
    it 'successfully completes journey and sets fare' do
      journey.complete('Temple')
      expect(journey.fare).to eq Journey::BASE_FARE
    end
    it 'should add penalty fare' do
      journey.penalty_fare
      expect(journey.fare).to eq Journey::PENALTY_FARE + Journey::BASE_FARE
    end

  end
end
