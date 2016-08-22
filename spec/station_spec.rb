require 'station'

describe Station do
  context 'initialization' do
    subject(:station) {described_class.new("Embankment",:One)}
    subject(:unnamed_station) {described_class.new}
    it 'should be initialized with a name' do
      expect(station.name).to eq 'Embankment'
    end
    it 'should be initialized with a zone' do
      expect(station.zone).to eq :One
    end
    it 'defaults to "Unknown" station name' do
      expect(unnamed_station.name).to eq 'Unknown'
    end
    it 'defaults to :Unknown station zone' do
      expect(unnamed_station.zone).to eq :Unknown
    end
  end
end
