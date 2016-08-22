require 'Station'

describe Station do
  let(:oyster) {double :oyster}

  context 'subject and zone testing' do
    subject {described_class.new("Ladbroke Grove Station", 2)}
    it 'is possible to read the name of the station' do
      expect(subject.name).to eq("Ladbroke Grove Station")
    end

    it 'is possible to read the zone of the station' do
      expect(subject.zone).to eq(2)
    end
  end


end
