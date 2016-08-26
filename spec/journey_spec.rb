require "journey"

describe Journey do

  let(:station) { double :station}

  describe '#fare' do
    it 'calculates a fare' do
      subject.start(station)
      subject.finish(station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end
  describe '#start' do
    it 'updates entry station' do
      subject.start(station)
      expect(subject.instance_variable_get(:@entry_station)).to eq station
    end
  end

  describe 'finish' do
    it 'updates exit station' do
      subject.finish(station)
      expect(subject.instance_variable_get(:@exit_station)).to eq station
    end
  end

end
