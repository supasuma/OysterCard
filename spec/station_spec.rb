require 'station'

describe Station do

  context 'initialization' do
    let(:station) {described_class.new(name: 'Bank', zone: :one)}

    it 'initialized with name' do
      expect(station.name).to eq 'Bank'
    end

    it 'initialized with zone' do
      expect(station.zone).to eq :one
    end
  end
end
