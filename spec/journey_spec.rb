require 'journey'

describe Journey do

subject(:journey) {described_class.new("station")}

  context 'when created' do

    it 'instantiates with an entry station' do
      expect(journey.instance_variable_get(:@entry_station)).to eq "station"
    end

    it 'instantiates with no exit station' do
      expect(journey.instance_variable_get(:@exit_station)).to be_nil
    end

    it 'instantiates with the custom minimum fare' do
      expect(journey.fare).to eq 1
    end

  end

  context 'when journey finished' do

    before do
      journey.complete("station2")
    end

    it 'retains the entry station' do
    expect(journey.instance_variable_get(:@entry_station)).to eq "station"
    end

    it 'updates exit station' do
      expect(journey.instance_variable_get(:@exit_station)).to eq "station2"
    end

    it 'expects minimum fare to remain the same' do
      expect(journey.fare).to eq 1
    end
  end

  describe '#receipt' do

    it 'returns single journey data' do
      journey.complete("station2")
      expect(journey.receipt).to eq ({entry: "station", exit: "station2"})
    end

  end

end
