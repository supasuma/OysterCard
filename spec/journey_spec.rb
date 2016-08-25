require 'journey'

describe Journey do


  subject { described_class.new(entry_station) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station}

  it 'records the entry station' do
    expect(subject.entry_station).to eq entry_station
  end
  it 'records the exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq exit_station
  end
end
