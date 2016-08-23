require 'journey'

describe Journey do

  let(:station) {double(:station, :zone1)}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it "has a penalty far by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when finishing a journey" do
    expect(subject.finish).to eq subject
  end

end
