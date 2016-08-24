require 'journey_log'

describe JourneyLog do
let(:station) {double(:station)}
let(:exit_station) {double(:station)}
let(:journey_class) {double(:journey_class, new: journey)}
let(:journey) {double(:journey, finish: {:entry => station, :exit => exit_station})}

subject(:journeylog) {described_class.new(journey_class)}



describe '#start' do
  it 'should create new journeys' do
    journeylog.start(station)
    expect(journeylog.instance_variable_get(:@current_journey)).not_to be_nil
  end
end

describe '#finish' do
  before do
    journeylog.start(station)
  end

  it 'should add exit station to current_journey' do
    journeylog.finish(exit_station)
    expect(journeylog.instance_variable_get(:@current_journey)).to have_received(:finish).with(exit_station)
  end
  it 'should add journey to history' do
    journeylog.finish(exit_station)
    expect(journeylog.journey_history).to eq([{:entry => station, :exit => exit_station}])
  end
end
end
