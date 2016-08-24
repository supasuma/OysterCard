require 'journey'

describe Journey do

  let(:station) {double(:station)}
  let(:exit_station) {double (:station)}
  subject(:journey) {described_class.new(station)}


  it "has a penalty far by default" do
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it "returns itself when finishing a journey" do
    hash = {:entry => station, :exit => exit_station}
    expect(journey.finish(exit_station)).to eq hash
  end

end
