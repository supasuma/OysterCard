require 'journey'

describe Journey do

  let(:station) {double(:station)}
  let(:exit_station) {double (:station)}
  subject(:journey) {described_class.new(station)}

  it "returns itself when finishing a journey" do
    hash = {:entry => station, :exit => exit_station}
    expect(journey.finish(exit_station)).to eq hash
  end

describe '#fare' do
  let(:station_one) {double(:station, zone: 1)}
  let(:station_two) {double(:station, zone: 2 )}
  let(:station_three) {double(:station, zone: 3)}
  let(:station_four) {double(:station, zone: 4)}
  let(:station_five) {double(:station, zone: 5)}

context 'from zone 1' do
  subject(:journey) {described_class.new(station_one)}
  it 'should calculate correct fare zone 1 to zone 5' do
    journey.finish(station_five)
    expect(journey.fare).to eq(5)
  end
  it 'should calculate correct fare zone 1 to zone 3' do
    journey.finish(station_three)
    expect(journey.fare).to eq(3)
  end
  it 'should calculate correct fare zone 1 to zone 1' do
    journey.finish(station_one)
    expect(journey.fare).to eq(1)
  end
end

context 'from zone 3' do
  subject(:journey) {described_class.new(station_three)}
  it 'should calculate correct fare zone 3 to zone 1' do
    journey.finish(station_one)
    expect(journey.fare).to eq(3)
  end
  it 'should calculate correct fare zone 3 to zone 3' do
    journey.finish(station_three)
    expect(journey.fare).to eq(1)
  end
  it 'should calculate correct fare zone 3 to zone 5' do
    journey.finish(station_five)
    expect(journey.fare).to eq(3)
  end
end

end

end
