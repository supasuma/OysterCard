require "journey"

describe Journey do

  let(:station1) { double :station1, zone: 1}
  let(:station2) { double :station2, zone: 2}
  let(:station3) { double :station3, zone: 3}

  describe '#fare' do
    it 'calculates a fare within the same zone' do
      subject.start(station1)
      subject.finish(station1)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'calculates a fare when travelling from zones 1 to 2' do
      subject.start(station1)
      subject.finish(station2)
      expect(subject.fare).to eq Journey::MINIMUM_FARE + 1
    end

    it 'calculates a fare when travelling from zones 2 to 1' do
      subject.start(station2)
      subject.finish(station1)
      expect(subject.fare).to eq Journey::MINIMUM_FARE + 1
    end

  end
  describe '#start' do
    it 'updates entry station' do
      subject.start(station1)
      expect(subject.instance_variable_get(:@entry_station)).to eq station1
    end
  end

  describe 'finish' do
    it 'updates exit station' do
      subject.finish(station1)
      expect(subject.instance_variable_get(:@exit_station)).to eq station1
    end
  end

end
