require 'journey'

describe Journey do


  subject { described_class.new(station_entry) }
  let(:station_entry) { double :station_entry }
  let(:station_exit) { double :station_exit }

  it 'records the entry station' do
    expect(subject.entry_station).to eq entry_station
  end
  it 'records the exit station' do
    expect(subject.exit_station).to eq exit_station
  end
end
